-- Schema for Domain: library | Business: Education | Version: v1_ecm
-- Generated on: 2026-05-06 12:28:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`library` COMMENT 'Governs academic library services including physical and digital resource cataloging, acquisitions, circulation, interlibrary loan, electronic resource licensing, and patron services via Alma/Ex Libris. Supports OER tracking, discovery services, scholarly communication, and research support for faculty and students.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`library`.`bib_record` (
    `bib_record_id` BIGINT COMMENT 'Unique identifier for the bibliographic record in the library catalog. Primary key for the bibliographic master record representing a distinct intellectual work.',
    `access_restrictions` STRING COMMENT 'Description of any restrictions on access to the resource, including licensing limitations, embargo periods, or institutional access requirements.',
    `acquisition_date` DATE COMMENT 'Date when the first item associated with this bibliographic record was acquired by the library. Used for collection age analysis and accreditation reporting.',
    `author` STRING COMMENT 'Primary author, creator, or corporate body responsible for the intellectual content. Includes personal names, corporate entities, or conference names.',
    `bib_record_description` STRING COMMENT 'Physical characteristics of the resource including pagination, dimensions, illustrations, and accompanying materials. Example: 324 pages : illustrations ; 24 cm.',
    `catalog_status` STRING COMMENT 'Current lifecycle status of the bibliographic record in the catalog. Determines visibility in discovery systems and availability for circulation.. Valid values are `active|suppressed|deleted|in_process|withdrawn`',
    `cataloging_level` STRING COMMENT 'Level of completeness and detail in the bibliographic description. Examples include full-level, core-level, minimal-level, or provisional cataloging.',
    `cip_code` STRING COMMENT 'Taxonomic code classifying the subject matter for academic program alignment. Used for collection development and accreditation reporting.',
    `circulation_count` STRING COMMENT 'Total number of times items associated with this bibliographic record have been checked out. Used for collection usage analysis and weeding decisions.',
    `copyright_year` STRING COMMENT 'Year of copyright as stated in the resource. Used for intellectual property tracking and rights management.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the bibliographic record was first created in the library catalog system. Used for audit trails and collection development analysis.',
    `dewey_call_number` STRING COMMENT 'Dewey Decimal Classification number for subject-based organization. Alternative classification system used in some academic and public libraries.',
    `doi` STRING COMMENT 'Persistent identifier for digital scholarly resources. Used for electronic resource linking, citation tracking, and scholarly communication.',
    `edition` STRING COMMENT 'Edition information indicating version, revision, or issue of the work. Examples include Second edition, Revised, Directors cut.',
    `encoding_level` STRING COMMENT 'Code indicating the level of bibliographic control and completeness of the MARC record. Used for quality assessment and record enhancement workflows.',
    `format_type` STRING COMMENT 'High-level categorization of the physical or digital format of the resource. Determines circulation policies, shelving, and discovery facets.. Valid values are `monograph|serial|electronic|audiovisual|manuscript|map`',
    `holdings_count` STRING COMMENT 'Total number of physical or electronic holdings attached to this bibliographic record. Used for collection size reporting and availability display.',
    `isbn` STRING COMMENT 'Unique commercial book identifier for monographs. May include ISBN-10 or ISBN-13 format. Used for acquisitions, cataloging, and discovery.',
    `issn` STRING COMMENT 'Unique identifier for serial publications including journals, magazines, and continuing resources. Eight-digit code used for periodical management and discovery.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code representing the primary language of the intellectual content. Used for discovery filtering and collection analysis.',
    `last_circulation_date` DATE COMMENT 'Date of the most recent checkout of any item associated with this bibliographic record. Used for collection evaluation and retention decisions.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the cataloger or system process that last updated the bibliographic record. Supports change tracking and accountability.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bibliographic record. Used for change tracking, synchronization, and data quality monitoring.',
    `lc_call_number` STRING COMMENT 'Library of Congress classification number used for subject-based shelving and retrieval. Primary call number for academic libraries.',
    `lccn` STRING COMMENT 'Unique identifier assigned by the Library of Congress for cataloging and bibliographic control. Used for authoritative cataloging and national bibliography.',
    `marc_record` STRING COMMENT 'Full MARC 21 bibliographic record in ISO 2709 or MARCXML format. Contains complete structured metadata for interoperability and data exchange.',
    `material_type` STRING COMMENT 'Specific material or media type describing the physical or digital carrier. Examples include print book, DVD, streaming video, e-book, microfilm.',
    `mms_code` STRING COMMENT 'Alma-specific unique identifier for the bibliographic record in the MARC Management System. Used for system-level record tracking and API integration.',
    `notes` STRING COMMENT 'Additional descriptive information not captured in other fields. May include bibliographic history, contents notes, summary, or restrictions on access.',
    `oclc_number` STRING COMMENT 'Unique identifier assigned by OCLC WorldCat for shared cataloging and interlibrary loan. Enables global resource discovery and bibliographic data sharing across institutions.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether the resource is an Open Educational Resource freely available for educational use. Supports OER tracking and affordability initiatives.',
    `peer_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the resource has undergone peer review process. Critical for scholarly research and academic quality assessment.',
    `publication_place` STRING COMMENT 'Geographic location where the resource was published or distributed. Includes city and country information.',
    `publication_year` STRING COMMENT 'Year the resource was published, issued, or released. Used for chronological sorting, collection development, and discovery filtering.',
    `publisher` STRING COMMENT 'Name of the publisher, distributor, or issuing body responsible for making the resource available. Used for acquisitions and cataloging.',
    `record_source` STRING COMMENT 'Origin of the bibliographic record, such as original cataloging, OCLC import, vendor-supplied metadata, or batch load. Used for quality control and provenance tracking.',
    `series_statement` STRING COMMENT 'Information about the series to which the resource belongs, including series title and numbering. Used for collection grouping and discovery.',
    `subject_headings` STRING COMMENT 'Controlled vocabulary subject terms describing the intellectual content. Includes Library of Congress Subject Headings (LCSH) or Medical Subject Headings (MeSH). Supports subject-based discovery.',
    `suppressed_from_discovery` BOOLEAN COMMENT 'Indicates whether the bibliographic record is hidden from public discovery interfaces while remaining in the catalog. Used for records in process or with access restrictions.',
    `title` STRING COMMENT 'Full title of the intellectual work including main title, subtitle, and statement of responsibility. Primary discovery field for catalog searches.',
    `url` STRING COMMENT 'Web address providing direct access to electronic resources. Used for e-books, streaming media, and digital collections.',
    `created_by` STRING COMMENT 'Username or identifier of the cataloger or system process that created the bibliographic record. Used for workflow tracking and quality control.',
    CONSTRAINT pk_bib_record PRIMARY KEY(`bib_record_id`)
) COMMENT 'Bibliographic master record representing a distinct intellectual work in the library catalog. Stores MARC-based metadata including title, author, edition, publication year, ISBN/ISSN, OCLC number, CIP classification, subject headings, language, format type (monograph, serial, electronic, AV), and discovery metadata. Sourced from Alma/Ex Libris catalog module. Serves as the authoritative catalog entry for all physical and digital holdings.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`holding` (
    `holding_id` BIGINT COMMENT 'Unique identifier for the holding record. Primary key. Represents the librarys ownership or access rights to a specific manifestation of a bibliographic work.',
    `bib_record_id` BIGINT COMMENT 'Foreign key reference to the bibliographic record that this holding is linked to. Represents the intellectual work that this holding manifests.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to library.collection. Business justification: holding has collection_code (STRING) and collection_name (STRING) that reference collection. Business: holdings belong to library collections (named groupings of materials managed as units). This is a',
    `access_policy` STRING COMMENT 'The policy governing who may access this holding and under what conditions. Common policies include open access, restricted access, staff only, special permission required, or course reserves.. Valid values are `open|restricted|staff_only|special_permission|course_reserves`',
    `acquisition_date` DATE COMMENT 'The date on which the library acquired ownership or access rights to this holding. Critical for tracking collection growth and retention policies.',
    `acquisition_method` STRING COMMENT 'The method by which the library acquired this holding. Common methods include purchase, gift, exchange, deposit, license agreement, or subscription.. Valid values are `purchase|gift|exchange|deposit|license|subscription`',
    `call_number` STRING COMMENT 'The classification number and location code used to organize and retrieve the item on library shelves. Typically follows Library of Congress (LC) or Dewey Decimal Classification (DDC) systems.',
    `call_number_type` STRING COMMENT 'The classification system used for the call number. Common types include Library of Congress (LC), Dewey Decimal, Superintendent of Documents (SuDoc), or local custom schemes.. Valid values are `lc|dewey|sudoc|local|other`',
    `copy_statement` STRING COMMENT 'A textual statement describing the copies held by the library. Used for serials and multi-volume sets to indicate which volumes, issues, or parts are held.',
    `copyright_status` STRING COMMENT 'The copyright status of this holding. Indicates whether the work is protected by copyright, in the public domain, has unknown status, or is covered by a specific license agreement.. Valid values are `in_copyright|public_domain|unknown|licensed`',
    `created_date` TIMESTAMP COMMENT 'The timestamp when this holding record was first created in the library system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the price amount. Examples include USD, EUR, GBP, CAD.. Valid values are `^[A-Z]{3}$`',
    `digitization_status` STRING COMMENT 'The status of digitization efforts for this holding. Tracks whether the item has been digitized, is scheduled for digitization, or is not applicable for digital conversion.. Valid values are `not_digitized|in_queue|in_progress|completed|not_applicable`',
    `electronic_access_url` STRING COMMENT 'The URL providing electronic access to this holding. Applicable for electronic resources, digital collections, and online subscriptions.',
    `enumeration_chronology` STRING COMMENT 'Structured data describing the enumeration (volume, issue, part numbers) and chronology (dates) of serial holdings. Critical for tracking journal and serial completeness.',
    `fund_code` STRING COMMENT 'The code identifying the budget fund used to acquire this holding. Critical for financial tracking and collection development budget management.',
    `holding_type` STRING COMMENT 'Classification of the holding based on its format and manifestation. Distinguishes between physical items, electronic resources, digital collections, microforms, serials, and monographs.. Valid values are `physical|electronic|digital|microform|serial|monograph`',
    `holdings_status` STRING COMMENT 'The current lifecycle status of this holding record. Indicates whether the holding is active and available, inactive, withdrawn from the collection, lost, missing, or in processing.. Valid values are `active|inactive|withdrawn|lost|missing|in_process`',
    `internal_note` STRING COMMENT 'A note visible only to library staff. May include information about processing status, preservation concerns, or administrative details.',
    `item_count` STRING COMMENT 'The total number of individual items (copies) associated with this holding record. For physical holdings, this represents the number of physical copies; for electronic holdings, this may represent the number of concurrent users or licenses.',
    `last_inventory_date` DATE COMMENT 'The date when this holding was last physically inventoried or verified. Used for collection management and loss prevention.',
    `last_modified_date` TIMESTAMP COMMENT 'The timestamp when this holding record was last updated or modified. Used for audit trail and change tracking.',
    `library_code` STRING COMMENT 'The code identifying the library branch or unit that owns or manages this holding. Used in multi-campus or multi-branch library systems.',
    `library_name` STRING COMMENT 'The full name of the library branch or unit that owns or manages this holding.',
    `license_code` STRING COMMENT 'The code identifying the license agreement governing access to this electronic holding. Links to detailed license terms, usage rights, and restrictions.',
    `material_type` STRING COMMENT 'The physical or digital format of the holding. Examples include book, journal, DVD, e-book, streaming video, database, manuscript, map, or dataset.',
    `mms_code` STRING COMMENT 'The unique identifier assigned by Alma/Ex Libris for this holding record in the Metadata Management System. Used for system-level tracking and integration.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether this holding is designated as an Open Educational Resource. True if the resource is freely accessible and openly licensed for educational use; false otherwise.',
    `permanent_location` STRING COMMENT 'The permanent home location for this holding. Distinct from temporary location, which may change due to circulation, reserves, or special exhibits.',
    `preservation_priority` STRING COMMENT 'The priority level assigned for preservation and conservation activities. High priority items may require special handling, climate control, or digitization.. Valid values are `high|medium|low|none`',
    `price_amount` DECIMAL(18,2) COMMENT 'The purchase price or subscription cost paid for this holding. Used for financial reporting and cost-per-use analysis.',
    `proxy_enabled` BOOLEAN COMMENT 'Indicates whether remote access to this electronic holding is enabled through the librarys proxy server or authentication system. True if proxy access is enabled; false otherwise.',
    `public_note` STRING COMMENT 'A note visible to library patrons in the public catalog. May include information about access restrictions, special handling, or usage instructions.',
    `receiving_status` STRING COMMENT 'The status of serial or continuing resource receipt. Indicates whether the library is actively receiving issues, has completed the subscription, or has ceased receiving.. Valid values are `complete|in_progress|ceased|cancelled|on_order`',
    `retention_policy` STRING COMMENT 'The policy governing how long the library will retain this holding. May specify permanent retention, time-based retention, or conditions for weeding and deaccessioning.',
    `shelving_location` STRING COMMENT 'The specific physical or virtual location where the holding is stored or accessed. Examples include stacks, reference, reserves, special collections, or electronic resource platform.',
    `statistical_code` STRING COMMENT 'A code used for statistical reporting and analysis of library holdings. May be used to track collection development priorities, funding sources, or reporting categories.',
    `suppressed_from_discovery` BOOLEAN COMMENT 'Indicates whether this holding is suppressed from public discovery interfaces. True if the holding should not appear in the library catalog or discovery services; false if it is publicly discoverable.',
    `temporary_location` STRING COMMENT 'The current temporary location for this holding, if different from the permanent location. Used when items are on course reserves, special display, or temporary storage.',
    `vendor_code` STRING COMMENT 'The code identifying the vendor or supplier from whom this holding was acquired. Used for acquisitions tracking and vendor performance analysis.',
    CONSTRAINT pk_holding PRIMARY KEY(`holding_id`)
) COMMENT 'Physical or electronic holding record linked to a bibliographic record, representing the librarys ownership or access rights to a specific manifestation of a work. Tracks call number, shelving location, library branch, collection code, acquisition date, retention policy, and item count. Sourced from Alma/Ex Libris holdings management module. Distinct from the bib_record (what exists) and item (individual copy).';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`item` (
    `item_id` BIGINT COMMENT 'Unique identifier for the library item. Primary key representing the individual physical copy or digital instance of a library holding.',
    `holding_id` BIGINT COMMENT 'Reference to the parent holding record that groups items of the same bibliographic resource at a specific location.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or estimated value of the item at time of acquisition in local currency.',
    `acquisition_date` DATE COMMENT 'Date when the item was acquired by the library through purchase, donation, or other means.',
    `acquisition_method` STRING COMMENT 'Method by which the item was acquired (purchase, gift, exchange, deposit, or transfer).. Valid values are `purchase|gift|exchange|deposit|transfer`',
    `barcode` STRING COMMENT 'Unique barcode identifier affixed to the physical item for circulation scanning and tracking. The externally-known unique code for this resource.. Valid values are `^[A-Z0-9]{8,20}$`',
    `call_number` STRING COMMENT 'Classification number used to organize and locate the item on library shelves. May follow Library of Congress (LC), Dewey Decimal, or local classification schemes.',
    `call_number_type` STRING COMMENT 'Classification scheme used for the call number (Library of Congress, Dewey Decimal, SuDoc, local, or other).. Valid values are `lc|dewey|sudoc|local|other`',
    `cataloging_date` DATE COMMENT 'Date when the item record was created or cataloged in the library system.',
    `chronology` STRING COMMENT 'Date or time period designation for serial items (e.g., January 2023 or Spring 2022). Complements enumeration for periodicals.',
    `condition_notes` STRING COMMENT 'Free-text description of specific damage, wear, or preservation concerns for the item. Documents condition details beyond the physical_condition field.',
    `copy_number` STRING COMMENT 'Sequential copy identifier when multiple identical items exist for the same holding. Distinguishes duplicate copies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Date when the currently loaned item is scheduled to be returned. Null if item is not currently on loan.',
    `enumeration` STRING COMMENT 'Volume, issue, or part designation for serial items (e.g., Vol. 12, No. 3 or Part 2). Used for multi-part works and periodicals.',
    `internal_note` STRING COMMENT 'Staff-only note for internal library operations and communication. Not visible to patrons.',
    `inventory_date` DATE COMMENT 'Date when the item was last physically verified during inventory or shelf-reading activities.',
    `inventory_status` STRING COMMENT 'Result of the most recent physical inventory check indicating whether the item was found and in expected condition.. Valid values are `verified|not_found|misshelved|damaged|other`',
    `is_fragile` BOOLEAN COMMENT 'Flag indicating whether the item requires special handling due to fragility, age, or preservation concerns.',
    `is_magnetic_media` BOOLEAN COMMENT 'Flag indicating whether the item contains magnetic media requiring special security gate handling (e.g., CDs, DVDs, videotapes).',
    `is_suppressed` BOOLEAN COMMENT 'Flag indicating whether the item is hidden from public catalog display. Used for items in processing, restricted materials, or withdrawn items.',
    `item_status` STRING COMMENT 'Current lifecycle status of the item indicating availability for circulation and current operational state. [ENUM-REF-CANDIDATE: available|on_loan|in_transit|on_hold_shelf|missing|lost|withdrawn|in_process — 8 candidates stripped; promote to reference product]',
    `last_loan_date` DATE COMMENT 'Date when the item was most recently checked out to a patron. Used for collection assessment and weeding decisions.',
    `last_return_date` DATE COMMENT 'Date when the item was most recently returned by a patron.',
    `loan_count` STRING COMMENT 'Total number of times this item has been loaned to patrons since acquisition. Tracks circulation activity and usage.',
    `location_code` STRING COMMENT 'Code representing the current physical or virtual location of the item within the library system (e.g., main stacks, reference, special collections, branch library).. Valid values are `^[A-Z0-9_]{2,10}$`',
    `location_name` STRING COMMENT 'Human-readable name of the current location where the item is shelved or stored.',
    `material_type` STRING COMMENT 'Physical or digital format classification of the item. Categorical field that segments the resource population by format. [ENUM-REF-CANDIDATE: book|journal|dvd|cd|microfilm|map|manuscript|thesis|electronic_resource — 9 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'Username or identifier of the library staff member who last modified the item record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the item record was last updated in the system.',
    `physical_condition` STRING COMMENT 'Assessment of the items physical state and preservation needs. Used to prioritize conservation and replacement decisions.. Valid values are `excellent|good|fair|poor|damaged|needs_repair`',
    `policy` STRING COMMENT 'Circulation policy governing loan rules, loan period, renewals, and holds for this item. Determines borrowing privileges and restrictions.. Valid values are `general_circulation|reserve|reference|non_circulating|special_collections|restricted`',
    `process_type` STRING COMMENT 'Current workflow or processing status indicating the items stage in library operations (acquisition, cataloging, preservation, etc.). [ENUM-REF-CANDIDATE: acquisition|cataloging|binding|preservation|digitization|weeding|missing|lost — 8 candidates stripped; promote to reference product]',
    `provenance_notes` STRING COMMENT 'Historical ownership and custodial information for the item. Particularly important for special collections, rare books, and archival materials.',
    `public_note` STRING COMMENT 'Note visible to library patrons in the catalog, providing additional information about the item (e.g., Includes supplementary materials, Latest issue available at reference desk).',
    `receiving_date` DATE COMMENT 'Date when the item was physically received by the library from the vendor or donor.',
    `statistical_code` STRING COMMENT 'Local code used for collection analysis, reporting, and statistical tracking. May represent fund codes, collection codes, or other local classifications.',
    `withdrawal_date` DATE COMMENT 'Date when the item was removed from the active collection through weeding, disposal, or transfer.',
    `withdrawal_reason` STRING COMMENT 'Reason for removing the item from the collection. Used for collection development analysis and reporting.. Valid values are `damaged|lost|obsolete|duplicate|low_use|transferred`',
    `created_by` STRING COMMENT 'Username or identifier of the library staff member who created the item record.',
    CONSTRAINT pk_item PRIMARY KEY(`item_id`)
) COMMENT 'Individual physical copy or digital instance of a library holding. Tracks barcode, item policy, material type, process type, current location, due date, number of loans, last loan date, condition, and provenance notes. Sourced from Alma/Ex Libris item management. Represents the loanable unit for circulation transactions.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`patron` (
    `patron_id` BIGINT COMMENT 'Unique identifier for the library patron record. Primary key for the patron entity.',
    `identity_account_id` BIGINT COMMENT 'Foreign key linking to technology.identity_account. Business justification: Every library patron requires a university NetID/identity account for authentication to library catalog, electronic resources, ILL systems, and self-service portals. Essential for SSO integration, acc',
    `accessibility_needs` STRING COMMENT 'Description of any accessibility accommodations or assistive technology requirements the patron has registered with the library.',
    `alternate_email_address` STRING COMMENT 'Secondary email address for patron communications when primary institutional email is unavailable.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `barcode` STRING COMMENT 'Physical library card barcode number used for circulation transactions and self-service kiosks.',
    `block_reason` STRING COMMENT 'Detailed explanation of why the patron account is blocked, including specific policy violations or outstanding obligations.',
    `blocked_status` BOOLEAN COMMENT 'Indicates whether the patrons borrowing privileges are currently blocked due to excessive fines, overdue materials, or policy violations.',
    `borrower_category` STRING COMMENT 'Granular borrowing classification that defines specific circulation policies, loan limits, and resource access levels.. Valid values are `standard|extended|restricted|temporary|alumni|reciprocal`',
    `campus_location` STRING COMMENT 'Primary campus or branch location associated with the patron, determining default pickup library and service location.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this patron record was first created in the library system.',
    `directory_opt_out_flag` BOOLEAN COMMENT 'Indicates whether the patron has opted out of having their information included in public directory services or patron lists.',
    `email_address` STRING COMMENT 'Primary institutional email address for library communications, overdue notices, and hold notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expiration_date` DATE COMMENT 'The date when the patrons borrowing privileges expire, typically aligned with enrollment or employment end dates.',
    `external_system_sync_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent synchronization with external systems such as Ellucian Banner SIS or Workday HCM.',
    `ferpa_consent_flag` BOOLEAN COMMENT 'Indicates whether the patron has provided consent for disclosure of library records under FERPA regulations.',
    `full_name` STRING COMMENT 'Complete legal name of the patron as registered in the institutional system.',
    `interlibrary_loan_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patron is authorized to request materials through interlibrary loan services.',
    `language_preference` STRING COMMENT 'The patrons preferred language for library communications and interface display, using ISO 639-2 three-letter language codes. [ENUM-REF-CANDIDATE: ENG|SPA|FRA|DEU|CHI|JPN|ARA|RUS|POR|ITA — 10 candidates stripped; promote to reference product]',
    `last_activity_date` DATE COMMENT 'The most recent date the patron engaged in any library transaction (checkout, return, login, request).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this patron record was most recently updated.',
    `notes` STRING COMMENT 'Free-text notes maintained by library staff regarding special circumstances, service history, or account-specific information.',
    `patron_type` STRING COMMENT 'Classification of the patron based on their institutional affiliation, determining borrowing privileges and loan periods.. Valid values are `undergraduate_student|graduate_student|faculty|staff|community_borrower|visiting_scholar`',
    `phone_number` STRING COMMENT 'Primary contact phone number for urgent library notifications and account recovery.',
    `preferred_name` STRING COMMENT 'The name the patron prefers to be addressed by, which may differ from their legal name.',
    `preferred_notification_channel` STRING COMMENT 'The patrons preferred method for receiving library communications including overdue notices, hold notifications, and service announcements.. Valid values are `email|sms|phone|mail`',
    `primary_affiliation` STRING COMMENT 'The patrons primary organizational unit or department within the institution (e.g., College of Engineering, Department of History).',
    `proxy_authorization_flag` BOOLEAN COMMENT 'Indicates whether the patron has authorized proxy borrowers to check out materials on their behalf.',
    `registration_date` DATE COMMENT 'The date when the patron account was first created in the library system.',
    `research_support_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patron is eligible for specialized research support services including subject librarian consultations and advanced resource access.',
    `special_collections_access_flag` BOOLEAN COMMENT 'Indicates whether the patron has been granted access to restricted special collections, archives, and rare materials.',
    `statistical_category` STRING COMMENT 'Classification code used for library usage reporting and analytics, often aligned with institutional reporting categories or IPEDS classifications.',
    `total_charges_outstanding` DECIMAL(18,2) COMMENT 'The cumulative monetary amount of unpaid charges including replacement costs, processing fees, and service charges.',
    `total_fines_outstanding` DECIMAL(18,2) COMMENT 'The cumulative monetary amount of unpaid fines and fees owed by the patron for overdue materials, lost items, and other library charges.',
    CONSTRAINT pk_patron PRIMARY KEY(`patron_id`)
) COMMENT 'Library patron master record representing any individual authorized to use library services — students, faculty, staff, and community borrowers. Stores patron type, borrower category, primary institutional affiliation, contact information, preferred notification channel, registration date, expiration date, total fines outstanding, blocked status, and FERPA consent flags. Sourced from Alma/Ex Libris patron management, synchronized with Ellucian Banner SIS. Distinct from the student domains student master — this is the library-specific borrower identity that aggregates all library privileges and history.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`loan` (
    `loan_id` BIGINT COMMENT 'Unique identifier for the circulation loan transaction. Primary key for the loan record.',
    `service_desk_id` BIGINT COMMENT 'Identifier of the circulation desk or service point where the item was checked out.',
    `item_id` BIGINT COMMENT 'Identifier of the library item (book, journal, media, equipment) that was checked out.',
    `employee_id` BIGINT COMMENT 'Identifier of the library staff member who processed the checkout transaction.',
    `loan_return_operator_employee_id` BIGINT COMMENT 'Identifier of the library staff member who processed the return transaction. Null if not yet returned.',
    `patron_id` BIGINT COMMENT 'Identifier of the library patron (student, faculty, staff, or community member) who checked out the item.',
    `policy_id` BIGINT COMMENT 'Identifier of the loan policy applied to this transaction, which determines loan period, renewal limits, and fine rules.',
    `barcode` STRING COMMENT 'Physical barcode identifier affixed to the item and scanned during checkout and return transactions.',
    `call_number` STRING COMMENT 'Library classification call number assigned to the item for shelving and retrieval (e.g., Library of Congress or Dewey Decimal classification).',
    `checkout_timestamp` TIMESTAMP COMMENT 'Date and time when the item was checked out to the patron. Principal business event timestamp for the loan transaction.',
    `claimed_returned_date` DATE COMMENT 'Date when the patron claimed to have returned the item. Null if no claim has been made.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this loan record was first created in the library system.',
    `due_date` DATE COMMENT 'Date by which the patron must return the item to avoid overdue fines.',
    `fine_amount_accrued` DECIMAL(18,2) COMMENT 'Total amount of fines and fees accrued on this loan transaction in the institutions base currency (typically USD for U.S. institutions).',
    `fine_amount_paid` DECIMAL(18,2) COMMENT 'Amount of fines and fees paid by the patron for this loan transaction in the institutions base currency.',
    `fine_amount_waived` DECIMAL(18,2) COMMENT 'Amount of fines and fees waived by library staff for this loan transaction in the institutions base currency.',
    `fine_collection_status` STRING COMMENT 'Current status of fine collection efforts for this loan (open, paid in full, waived, sent to external collections agency, or written off).. Valid values are `open|paid|waived|sent_to_collections|written_off`',
    `fine_payment_date` DATE COMMENT 'Date when the patron paid fines associated with this loan. Null if no payment has been made.',
    `fine_type` STRING COMMENT 'Category of fine or fee associated with this loan transaction (overdue, lost item, damaged item, service charge, replacement fee, or processing fee).. Valid values are `overdue|lost|damaged|service_charge|replacement|processing`',
    `fine_waiver_reason` STRING COMMENT 'Explanation or justification for waiving fines on this loan, such as system error, patron appeal, or staff discretion.',
    `is_claimed_returned` BOOLEAN COMMENT 'Flag indicating whether the patron has claimed to have returned the item but the library has no record of receiving it.',
    `is_lost` BOOLEAN COMMENT 'Flag indicating whether the item has been declared lost by the patron or the library.',
    `is_overdue` BOOLEAN COMMENT 'Flag indicating whether the loan is currently overdue (past the due date without being returned).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this loan record was last updated in the library system.',
    `loan_number` STRING COMMENT 'Business identifier for the loan transaction, often displayed to patrons and staff for reference and tracking.',
    `loan_status` STRING COMMENT 'Current lifecycle status of the loan transaction indicating whether the item is still checked out, returned, overdue, or in another state. [ENUM-REF-CANDIDATE: active|returned|overdue|lost|claimed_returned|renewed|recalled — 7 candidates stripped; promote to reference product]',
    `loan_type` STRING COMMENT 'Classification of the loan transaction by lending category (regular circulation, course reserve, interlibrary loan, equipment loan, or digital resource loan).. Valid values are `regular|reserve|interlibrary|equipment|digital`',
    `location_code` STRING COMMENT 'Code representing the physical or virtual location of the item at the time of checkout (e.g., main stacks, reference, media center).',
    `lost_date` DATE COMMENT 'Date when the item was declared lost. Null if the item has not been declared lost.',
    `material_type` STRING COMMENT 'Type of library material checked out (e.g., book, journal, DVD, laptop, tablet, microfilm) which may affect loan policies and fine structures.',
    `notes` STRING COMMENT 'Free-text notes recorded by library staff regarding special circumstances, patron requests, or issues related to this loan transaction.',
    `overdue_days` STRING COMMENT 'Number of days the item is overdue. Null or zero if not overdue.',
    `patron_group` STRING COMMENT 'Classification of the patron at the time of checkout (e.g., undergraduate, graduate, faculty, staff, community) which may affect loan policies.',
    `recall_due_date` DATE COMMENT 'Revised due date if the item has been recalled. Null if no recall is active.',
    `recall_requested` BOOLEAN COMMENT 'Flag indicating whether another patron has requested this item be recalled, requiring the current borrower to return it early.',
    `renewal_count` STRING COMMENT 'Number of times the patron has renewed this loan. Zero indicates no renewals have occurred.',
    `return_desk_code` BIGINT COMMENT 'Identifier of the circulation desk or service point where the item was returned. Null if not yet returned.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time when the item was returned by the patron. Null if the item has not yet been returned.',
    CONSTRAINT pk_loan PRIMARY KEY(`loan_id`)
) COMMENT 'Circulation loan transaction recording the checkout of a library item to a patron, including associated fines and fees. Captures checkout date/time, due date, return date, renewal count, loan policy applied, overdue status, fine type (overdue, lost, damaged, service charge), fine amount accrued, amount paid, amount waived, waiver reason, payment date, collection status, and the desk/operator that processed the transaction. Sourced from Alma/Ex Libris circulation and fines modules. Core transactional record for all physical and in-library digital lending activity and its financial consequences.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`hold_request` (
    `hold_request_id` BIGINT COMMENT 'Unique identifier for the hold request record. Primary key.',
    `bib_record_id` BIGINT COMMENT 'Identifier of the bibliographic title being requested. Used when hold is placed at title level rather than specific item level.',
    `building_id` BIGINT COMMENT 'Identifier of the library branch or service desk where the patron will collect the item once it becomes available.',
    `item_id` BIGINT COMMENT 'Identifier of the specific library item being requested. Links to the item master record.',
    `patron_id` BIGINT COMMENT 'Identifier of the patron who placed the hold request. Links to the patron master record in the library system.',
    `barcode` STRING COMMENT 'Physical barcode identifier of the specific item being requested, used for scanning and tracking during fulfillment process.',
    `call_number` STRING COMMENT 'Library classification call number of the requested item, used for shelving location and retrieval by staff.',
    `cancellation_date` DATE COMMENT 'Date when the hold request was cancelled, either by the patron, staff, or system due to expiration.',
    `cancellation_reason` STRING COMMENT 'Reason why the hold request was cancelled. Patron request indicates patron-initiated cancellation, item unavailable indicates the item was lost or withdrawn, expired indicates the pickup window passed.. Valid values are `patron_request|item_unavailable|expired|duplicate|other`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this hold request record was first created in the library management system. Used for audit trail and data lineage.',
    `estimated_availability_date` DATE COMMENT 'Projected date when the item is expected to become available for this hold request, based on current checkout due dates and queue position.',
    `expiration_date` DATE COMMENT 'Date when the hold request will expire if not fulfilled. After this date, the request is automatically cancelled and the item is made available to the next patron in queue.',
    `fulfillment_date` DATE COMMENT 'Date when the patron picked up the item and the hold request was marked as fulfilled.',
    `hold_shelf_expiration_date` DATE COMMENT 'Date when the item will be removed from the hold shelf if not picked up by the patron. Typically 7-14 days after the ready-for-pickup notification.',
    `isbn` STRING COMMENT 'International Standard Book Number of the requested title, used for bibliographic identification and interlibrary loan coordination.',
    `issn` STRING COMMENT 'International Standard Serial Number for journal or serial publications being requested.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the staff member or system process that last modified this hold request record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this hold request record was last updated. Tracks any status changes, updates to pickup location, or other modifications.',
    `material_type` STRING COMMENT 'Type of library material being requested. Affects processing workflow and pickup procedures, especially for special collections or equipment items.. Valid values are `book|journal|dvd|equipment|special_collections|electronic`',
    `notification_method` STRING COMMENT 'Communication channel used to notify the patron about the hold request status. Email is most common, SMS is used for urgent notifications.. Valid values are `email|sms|phone|mail`',
    `notification_sent_date` DATE COMMENT 'Date when the ready-for-pickup notification was sent to the patron via email, SMS, or other communication channel.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification has been sent to the patron informing them that the item is ready for pickup.',
    `owning_library_code` STRING COMMENT 'Code of the library branch or collection that owns the requested item. Used for routing and transfer logistics in multi-campus systems.',
    `patron_comments` STRING COMMENT 'Free-text comments or special instructions provided by the patron when placing the hold request, such as preferred pickup times or accessibility needs.',
    `patron_group` STRING COMMENT 'Classification of the patron who placed the request, used to determine loan periods, priority levels, and access privileges.. Valid values are `undergraduate|graduate|faculty|staff|alumni|community`',
    `pickup_location_code` STRING COMMENT 'Short code representing the pickup location, used for operational routing and display purposes.',
    `priority_level` STRING COMMENT 'Priority classification of the hold request. Faculty and reserve requests typically receive higher priority than standard patron requests.. Valid values are `standard|high|urgent|faculty|reserve`',
    `queue_position` STRING COMMENT 'Current position of this request in the hold queue for the title or item. Position 1 indicates next in line for fulfillment.',
    `request_date` DATE COMMENT 'Date when the patron placed the hold request. Used to determine queue position and priority.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the hold request, typically displayed to patrons and staff for tracking purposes.',
    `request_source` STRING COMMENT 'System or interface through which the hold request was submitted. OPAC (Online Public Access Catalog) is the traditional web catalog, discovery service includes third-party discovery tools.. Valid values are `opac|mobile_app|staff_interface|api|discovery_service`',
    `request_status` STRING COMMENT 'Current lifecycle status of the hold request. Pending indicates awaiting item availability, in transit indicates item is being transferred to pickup location, ready for pickup indicates item is available for patron collection, expired indicates pickup window has passed, cancelled indicates patron or staff cancelled the request, fulfilled indicates patron has picked up the item.. Valid values are `pending|in_transit|ready_for_pickup|expired|cancelled|fulfilled`',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold request was submitted by the patron. Principal business event timestamp for this transaction.',
    `request_type` STRING COMMENT 'Type of request placed by the patron. Hold is for unavailable items, recall is for expedited return of checked-out items, booking is for scheduled use, digitization is for scan-on-demand services.. Valid values are `hold|recall|booking|digitization`',
    `staff_notes` STRING COMMENT 'Internal notes added by library staff regarding the hold request processing, special handling requirements, or issues encountered.',
    `transit_arrival_date` DATE COMMENT 'Date when the item arrived at the pickup location and was placed on the hold shelf for patron collection.',
    `transit_start_date` DATE COMMENT 'Date when the item was sent in transit from the owning library to the pickup location.',
    CONSTRAINT pk_hold_request PRIMARY KEY(`hold_request_id`)
) COMMENT 'Patron-initiated hold or recall request placed on a library item or title that is currently unavailable. Tracks request date, expiration date, pickup location, queue position, request status (pending, in transit, ready for pickup, expired, cancelled), notification sent flag, and fulfillment date. Sourced from Alma/Ex Libris fulfillment module. Distinct from ILL requests which involve external libraries.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`ill_request` (
    `ill_request_id` BIGINT COMMENT 'Unique identifier for the interlibrary loan request record. Primary key.',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: ill_request contains bibliographic metadata (title, author, isbn, issn, oclc_number, publication_year, publisher, edition) that duplicates bib_record. Business: interlibrary loan requests may be for m',
    `patron_id` BIGINT COMMENT 'Identifier of the patron (student, faculty, or staff member) who submitted the interlibrary loan request.',
    `article_title` STRING COMMENT 'Title of the specific article or chapter being requested, for copy requests from journals or books.',
    `borrowing_institution_code` STRING COMMENT 'OCLC symbol or institutional code identifying the library requesting the material (typically the home institution for borrowing requests).',
    `cancellation_reason` STRING COMMENT 'Reason why the interlibrary loan request was cancelled.. Valid values are `patron_request|item_unavailable|duplicate_request|no_longer_needed|cost_exceeded|copyright_restriction`',
    `cancelled_date` DATE COMMENT 'Date when the interlibrary loan request was cancelled by the patron or library staff.',
    `copyright_compliance_flag` BOOLEAN COMMENT 'Indicates whether the interlibrary loan request complies with copyright law and institutional policies (e.g., CONTU guidelines for periodical copying).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged by the lending institution for providing the interlibrary loan service, including lending fees, shipping costs, and copyright fees.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount.. Valid values are `USD|CAD|EUR|GBP|AUD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interlibrary loan request record was first created in the library system.',
    `due_date` DATE COMMENT 'Date by which the borrowed material must be returned to the lending institution.',
    `issue` STRING COMMENT 'Issue number of the journal or serial publication containing the requested article.',
    `journal_title` STRING COMMENT 'Title of the journal or periodical containing the requested article, for copy requests.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the interlibrary loan request record was last updated or modified.',
    `lending_institution_code` STRING COMMENT 'OCLC symbol or institutional code identifying the external library or institution providing the requested material.',
    `lending_institution_name` STRING COMMENT 'Name of the external library or institution providing the requested material.',
    `needed_by_date` DATE COMMENT 'Date by which the patron requires the requested material, used to prioritize request processing.',
    `oclc_ill_transaction_number` STRING COMMENT 'Unique transaction identifier assigned by OCLC WorldShare ILL system for tracking the request across the library network.',
    `pages` STRING COMMENT 'Page range of the requested article or chapter within the source publication.',
    `patron_charged_amount` DECIMAL(18,2) COMMENT 'Amount charged to the patron for the interlibrary loan service, which may differ from the institutional cost.',
    `pickup_location` STRING COMMENT 'Library branch or service desk where the patron will pick up the requested material.',
    `received_date` DATE COMMENT 'Date when the requesting library received the material from the lending institution.',
    `renewal_count` STRING COMMENT 'Number of times the due date for the borrowed material has been extended or renewed.',
    `request_date` DATE COMMENT 'Date when the patron submitted the interlibrary loan request. Principal business event timestamp for the transaction.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the interlibrary loan request, typically generated by the library system.',
    `request_status` STRING COMMENT 'Current lifecycle status of the interlibrary loan request tracking its progress from submission through completion or cancellation. [ENUM-REF-CANDIDATE: submitted|pending|in_process|shipped|received|completed|returned|cancelled|unfilled — 9 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Type of interlibrary loan transaction: borrowing (requesting from another institution), lending (providing to another institution), copy request (article/chapter copy), or loan request (physical item loan).. Valid values are `borrowing|lending|copy_request|loan_request`',
    `returned_date` DATE COMMENT 'Date when the borrowed material was returned to the lending institution.',
    `shipped_date` DATE COMMENT 'Date when the lending institution shipped or transmitted the requested material.',
    `shipping_method` STRING COMMENT 'Method used to deliver the requested material: physical mail, courier service, electronic delivery, Ariel document transmission, DocLine, email, or fax. [ENUM-REF-CANDIDATE: physical_mail|courier|electronic_delivery|ariel|docline|email|fax — 7 candidates stripped; promote to reference product]',
    `staff_notes` STRING COMMENT 'Internal notes added by library staff for tracking, troubleshooting, or communication regarding the interlibrary loan request.',
    `volume` STRING COMMENT 'Volume number of the journal or serial publication containing the requested article.',
    CONSTRAINT pk_ill_request PRIMARY KEY(`ill_request_id`)
) COMMENT 'Interlibrary loan request record capturing borrowing and lending transactions with external institutions. Tracks request type (borrowing/lending), patron requester, requested title/OCLC number, lending institution, request date, due date, shipping method, status (submitted, in process, received, returned, cancelled), cost, and OCLC ILL transaction number. Sourced from Alma/Ex Libris ILL module. Supports resource sharing across the academic library network.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`fine` (
    `fine_id` BIGINT COMMENT 'Unique identifier for the library fine or fee record. Primary key.',
    `bib_record_id` BIGINT COMMENT 'FK to library.bib_record',
    `employee_id` BIGINT COMMENT 'Identifier of the library staff member who authorized the waiver. Used for audit trail and accountability.',
    `item_id` BIGINT COMMENT 'Identifier of the library item (book, journal, media) associated with this fine. Applicable for overdue, lost, or damaged item fines.',
    `loan_id` BIGINT COMMENT 'Identifier of the circulation loan transaction that originated this fine, if applicable. Null for non-loan-related fees such as service charges or lost item replacement fees.',
    `patron_id` BIGINT COMMENT 'Identifier of the library patron who incurred the fine or fee. Links to the patron master record in the library system.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Fine revenue posts to specific GL revenue accounts for revenue recognition, financial reporting, and reconciliation. Each fine type (overdue, lost item, processing) maps to distinct revenue accounts. ',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Library fines post to student billing accounts for consolidated billing statements, unified collections processes, and integrated account holds. Real business process: bursar offices require library f',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid by the patron toward this fine or fee. Cumulative sum of all payment transactions applied to this fine.',
    `amount_waived` DECIMAL(18,2) COMMENT 'Total amount waived or forgiven by library staff. Represents the portion of the fine that was administratively cancelled and is no longer owed.',
    `assessment_date` DATE COMMENT 'Date on which the fine or fee was assessed and recorded in the library system. Represents the business event date when the charge was created.',
    `balance_due` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the fine. Calculated as original amount minus amount paid minus amount waived. Represents the current outstanding liability.',
    `billing_export_date` DATE COMMENT 'Date on which the fine was exported to the student billing system. Null if not yet exported or if billing integration is not enabled.',
    `billing_integration_flag` BOOLEAN COMMENT 'Indicates whether this fine has been exported to the student billing system (e.g., Banner Student Accounts) for inclusion in the students account statement. True if exported, false otherwise.',
    `collections_date` DATE COMMENT 'Date on which the fine was sent to collections or the bursar office. Null if the fine has not been escalated.',
    `collections_status` STRING COMMENT 'Indicates whether the fine has been escalated to external collections or the institutions bursar office. Tracks the collections lifecycle stage.. Valid values are `not_sent|sent_to_collections|in_collections|resolved|recalled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fine record was first created in the library system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fine amounts. Typically the institutions base currency (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `daily_fine_rate` DECIMAL(18,2) COMMENT 'Per-day fine rate applied for overdue items. Used to calculate the total overdue fine based on the number of overdue days. Null for non-overdue fine types.',
    `dispute_date` DATE COMMENT 'Date on which the patron filed a dispute or appeal for this fine. Null if no dispute has been filed.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the patron has disputed or appealed this fine. True if a dispute has been filed, false otherwise.',
    `dispute_resolution` STRING COMMENT 'Outcome of the patrons dispute or appeal. Indicates whether the dispute is pending review, approved (fine waived), denied (fine upheld), or withdrawn by the patron.. Valid values are `pending|approved|denied|withdrawn`',
    `due_date` DATE COMMENT 'Date by which the fine or fee is expected to be paid. Used for aging analysis and collections escalation.',
    `fine_number` STRING COMMENT 'Human-readable business identifier for the fine record. Used for patron communication and reference in billing statements.',
    `fine_status` STRING COMMENT 'Current lifecycle status of the fine. Tracks whether the fine is open (unpaid), paid in full, waived, partially paid, sent to collections, or cancelled.. Valid values are `open|paid|waived|partially_paid|in_collections|cancelled`',
    `fine_type` STRING COMMENT 'Category of the fine or fee. Indicates whether the charge is for overdue materials, lost items, damaged items, replacement costs, processing fees, or other service charges.. Valid values are `overdue|lost_item|damaged_item|replacement_fee|processing_fee|service_charge`',
    `last_modified_by` STRING COMMENT 'Identifier of the user (library staff or system process) who last modified this fine record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fine record. Tracks changes to status, payments, waivers, or other attributes.',
    `library_location` STRING COMMENT 'Physical library branch or location where the fine originated. Used for multi-branch reporting and budget allocation.',
    `maximum_fine_amount` DECIMAL(18,2) COMMENT 'Cap or ceiling on the total fine amount for this fine type. Prevents overdue fines from exceeding the replacement cost of the item. Null if no cap is configured.',
    `notes` STRING COMMENT 'Free-text notes or comments added by library staff regarding the fine. May include patron communication history, dispute details, or special circumstances.',
    `original_amount` DECIMAL(18,2) COMMENT 'Initial amount of the fine or fee assessed in the institutions base currency. Represents the gross charge before any payments, waivers, or adjustments.',
    `overdue_days` STRING COMMENT 'Number of days the item was overdue at the time the fine was assessed. Applicable only for overdue fines; null for other fine types.',
    `patron_group` STRING COMMENT 'Category or affiliation of the patron who incurred the fine (e.g., undergraduate, graduate, faculty, staff, community). Denormalized from the patron record for segmentation analysis.',
    `payment_date` DATE COMMENT 'Date of the most recent payment applied to this fine. Null if no payment has been received.',
    `payment_method` STRING COMMENT 'Instrument or mechanism used for the most recent payment. Indicates whether the patron paid via cash, check, credit card, debit card, online portal, student account billing integration, or wire transfer. [ENUM-REF-CANDIDATE: cash|check|credit_card|debit_card|online|student_account|wire_transfer — 7 candidates stripped; promote to reference product]',
    `waiver_date` DATE COMMENT 'Date on which the fine waiver was approved and applied. Null if no waiver has been granted.',
    `waiver_reason` STRING COMMENT 'Free-text explanation or code indicating why the fine was waived. Examples include patron appeal, system error, first-time offense, or administrative discretion.',
    CONSTRAINT pk_fine PRIMARY KEY(`fine_id`)
) COMMENT 'Patron fine or fee record generated from overdue items, lost materials, damaged items, or service charges. Tracks fine type, originating loan or item, amount assessed, amount paid, amount waived, waiver reason, payment date, and collection status. Sourced from Alma/Ex Libris fines and fees module. Feeds into the billing domain for student account integration.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`acquisition_order` (
    `acquisition_order_id` BIGINT COMMENT 'Unique identifier for the library acquisition order record. Primary key for the acquisition order entity.',
    `bib_record_id` BIGINT COMMENT 'Foreign key linking to library.bib_record. Business justification: acquisition_order contains bibliographic metadata (title, author, publisher, publication_year, isbn, issn, edition) that duplicates bib_record. Business: acquisition orders are for materials that will',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Acquisition orders are charged to departmental cost centers for budget accountability. Departmental spending reports, cost allocation, and budget manager oversight require this link. Standard practice',
    `employee_id` BIGINT COMMENT 'Reference to the librarian or subject specialist responsible for selecting and approving this acquisition order as part of collection development.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Acquisition orders encumber specific GL accounts. Encumbrance reporting, budget-to-actual analysis, year-end accruals, and financial controls require this link. Each order must reference the GL accoun',
    `library_fund_id` BIGINT COMMENT 'Reference to the library fund or budget allocation code used to finance this acquisition order.',
    `library_vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom the library materials are being acquired.',
    `patron_id` BIGINT COMMENT 'Reference to the faculty member, librarian, or staff member who requested the acquisition of this library material.',
    `actual_receipt_date` DATE COMMENT 'Actual date when the ordered library materials were physically received and logged into the library system.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason code for why the acquisition order was cancelled, if applicable (e.g., out of print, budget constraints, duplicate order, vendor unable to supply).',
    `collection_code` STRING COMMENT 'Library collection code indicating the specific collection to which the acquired material will be added (e.g., reference, circulating, special collections, reserves).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquisition order record was first created in the library system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the acquisition order is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary discount amount applied to the list price, calculated from the discount percentage or negotiated as a fixed reduction.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the list price by the vendor, typically negotiated through library consortia or volume agreements.',
    `expected_receipt_date` DATE COMMENT 'Anticipated date when the ordered library materials are expected to be received from the vendor.',
    `invoice_date` DATE COMMENT 'Date when the vendor issued the invoice for this acquisition order.',
    `invoice_number` STRING COMMENT 'Vendor-issued invoice number associated with this acquisition order for payment processing and financial reconciliation.',
    `invoice_status` STRING COMMENT 'Current status of the vendor invoice associated with this acquisition order: pending (awaiting review), approved (authorized for payment), paid (payment completed), disputed (discrepancy identified), or cancelled (invoice voided).. Valid values are `pending|approved|paid|disputed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the acquisition order record was most recently updated or modified in the library system.',
    `list_price` DECIMAL(18,2) COMMENT 'Published or catalog price of the library material as listed by the vendor or publisher before any discounts or adjustments.',
    `location_code` STRING COMMENT 'Library location or branch code where the acquired material will be housed and made available to patrons.',
    `material_type` STRING COMMENT 'Classification of the library material being acquired: physical book, serial/periodical, electronic resource (e-book, database, e-journal), audiovisual material (DVD, CD), manuscript, or map.. Valid values are `book|serial|electronic_resource|audiovisual|manuscript|map`',
    `net_price` DECIMAL(18,2) COMMENT 'Final price paid for the library material after applying all discounts and adjustments to the list price.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the acquisition order, including special instructions, vendor communications, or internal processing notes.',
    `order_date` DATE COMMENT 'Date when the acquisition order was created and placed with the vendor.',
    `order_number` STRING COMMENT 'Externally-known unique order number assigned to this acquisition order for tracking and reference purposes.',
    `order_status` STRING COMMENT 'Current lifecycle status of the acquisition order: pending (awaiting approval), approved (authorized for purchase), sent (transmitted to vendor), received (materials delivered), cancelled (order voided), or closed (order completed and finalized).. Valid values are `pending|approved|sent|received|cancelled|closed`',
    `order_type` STRING COMMENT 'Classification of the acquisition order type indicating the procurement method: firm order (one-time purchase), approval plan (vendor-selected materials), standing order (recurring series), subscription (periodical), gift (donated materials), or exchange (reciprocal agreement).. Valid values are `firm|approval|standing_order|subscription|gift|exchange`',
    `payment_date` DATE COMMENT 'Date when payment was issued to the vendor for this acquisition order.',
    `quantity_ordered` STRING COMMENT 'Number of copies or units of the library material ordered from the vendor.',
    `quantity_received` STRING COMMENT 'Number of copies or units of the library material actually received from the vendor, which may differ from quantity ordered due to partial shipments or vendor shortages.',
    `receiving_status` STRING COMMENT 'Status indicating the receipt progress of the ordered materials: not received (no items delivered), partially received (some items delivered), fully received (all items delivered), or backordered (items delayed by vendor).. Valid values are `not_received|partially_received|fully_received|backordered`',
    `rush_order_flag` BOOLEAN COMMENT 'Boolean indicator of whether this acquisition order is marked as a rush or expedited order requiring priority processing and faster delivery.',
    `shipping_cost` DECIMAL(18,2) COMMENT 'Cost of shipping and handling charged by the vendor for delivery of the library materials.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Sales tax or value-added tax (VAT) amount applied to the acquisition order based on institutional tax status and vendor location.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total cost of the acquisition order including net price, shipping cost, and tax amount. Represents the final amount charged to the library fund.',
    CONSTRAINT pk_acquisition_order PRIMARY KEY(`acquisition_order_id`)
) COMMENT 'Purchase order record for acquiring new library materials — physical books, serials, electronic resources, and AV materials. Tracks vendor, fund code, order type (firm, approval, standing order, subscription), order date, expected receipt date, list price, discount, currency, invoice status, and receiving status. Sourced from Alma/Ex Libris acquisitions module. Drives the library collection development workflow.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`library_vendor` (
    `library_vendor_id` BIGINT COMMENT 'Unique identifier for the library vendor record. Primary key.',
    `account_number` STRING COMMENT 'The librarys account number or customer identifier assigned by the vendor for order tracking and invoicing.',
    `address_line1` STRING COMMENT 'First line of the vendors business mailing address, typically street address or PO Box.',
    `address_line2` STRING COMMENT 'Second line of the vendors business mailing address, typically suite, floor, or building number.',
    `approval_plan_flag` BOOLEAN COMMENT 'Indicates whether the library has an approval plan arrangement with this vendor, where materials matching a profile are automatically sent for review. True if approval plan is active; False otherwise.',
    `city` STRING COMMENT 'City or municipality of the vendors business address.',
    `claiming_interval_days` STRING COMMENT 'Number of days after expected delivery date before the library initiates a claim for missing or delayed materials. Used for automated claiming workflows.',
    `contract_end_date` DATE COMMENT 'Date when the librarys current contract or agreement with the vendor expires. Null if no formal contract exists or if the agreement is open-ended.',
    `contract_start_date` DATE COMMENT 'Date when the librarys current contract or agreement with the vendor became effective. Null if no formal contract exists.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the vendors business address (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the library system.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount percentage offered by the vendor on list prices for library materials. Expressed as a percentage (e.g., 10.00 for 10% discount).',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the vendor supports Electronic Data Interchange (EDI) for automated order transmission, invoicing, and claiming. True if EDI is available; False otherwise.',
    `edi_vendor_code` STRING COMMENT 'Unique identifier assigned to the vendor in the librarys EDI system for electronic order and invoice exchange. Populated only if EDI is enabled.',
    `firm_order_flag` BOOLEAN COMMENT 'Indicates whether the vendor is approved for firm (title-specific) orders. True if firm orders are allowed; False otherwise.',
    `last_order_date` DATE COMMENT 'Date of the most recent purchase order placed with this vendor. Used to identify inactive vendor relationships.',
    `notes` STRING COMMENT 'Free-text notes about the vendor relationship, special instructions, service issues, or account-specific details for library staff reference.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor, such as Net 30, Net 60, or prepayment required. Defines the payment due date relative to invoice date.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors business address.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the vendors preferred invoicing and payment currency (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact for order placement, invoicing inquiries, and account support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor organization for library acquisitions and account management.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary vendor contact for urgent order or delivery issues.',
    `return_policy` STRING COMMENT 'Vendors policy for returning damaged, incorrect, or unwanted materials, including time limits and restocking fees.',
    `shipping_method` STRING COMMENT 'Default shipping method used by the vendor for delivering library materials (e.g., ground, expedited, freight, electronic delivery).',
    `standing_order_flag` BOOLEAN COMMENT 'Indicates whether the vendor is approved for standing orders (automatic shipment of series or continuations). True if standing orders are allowed; False otherwise.',
    `state_province` STRING COMMENT 'State, province, or region of the vendors business address.',
    `subscription_flag` BOOLEAN COMMENT 'Indicates whether the vendor is approved for journal or database subscriptions. True if subscriptions are allowed; False otherwise.',
    `tax_id_number` STRING COMMENT 'Vendors tax identification number (e.g., Employer Identification Number in the USA, VAT number in the EU) for tax reporting and compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was last modified in the library system.',
    `vendor_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the vendor in the library acquisitions system. Used for ordering, invoicing, and reporting. Sourced from Alma/Ex Libris vendor management.. Valid values are `^[A-Z0-9]{3,20}$`',
    `vendor_name` STRING COMMENT 'Full legal or trading name of the library materials vendor, subscription agent, publisher, or database provider.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor relationship. Active vendors are approved for ordering; inactive vendors are no longer used; suspended vendors have temporary holds; pending approval vendors are under review.. Valid values are `active|inactive|suspended|pending_approval`',
    `vendor_type` STRING COMMENT 'Classification of the vendor by the type of library materials or services they provide. Book jobbers supply monographs, subscription agents manage journal subscriptions, publishers provide direct content, and database providers license electronic resources.. Valid values are `book_jobber|subscription_agent|publisher|database_provider|serials_vendor|media_vendor`',
    `website_url` STRING COMMENT 'Public website URL of the vendor for catalog browsing, account access, and support resources.',
    CONSTRAINT pk_library_vendor PRIMARY KEY(`library_vendor_id`)
) COMMENT 'Library materials vendor and subscription agent master record. Stores vendor name, vendor code, vendor type (book jobber, subscription agent, publisher, database provider), contact information, EDI capability flag, preferred currency, payment terms, and account status. Sourced from Alma/Ex Libris vendor management. Scoped to library acquisitions — distinct from institutional procurement vendors in the finance domain.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`library_fund` (
    `library_fund_id` BIGINT COMMENT 'Unique identifier for the library fund record. Primary key for the library fund entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Library funds are allocated to academic departments/cost centers. Budget variance analysis, financial consolidation, and departmental accountability reporting require linking library spending to insti',
    `donor_id` BIGINT COMMENT 'Reference to the donor or benefactor if this fund originates from a philanthropic gift or endowment. Null for institutionally-funded library funds.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Library fund expenditures post to institutional general ledger accounts for financial statement preparation, month-end close, and audit trails. Every library fund must map to GL account(s) for GASB/FA',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `parent_fund_library_fund_id` BIGINT COMMENT 'Reference to the parent fund in a hierarchical fund structure. Enables roll-up reporting from sub-funds to master funds. Null for top-level funds.',
    `primary_library_employee_id` BIGINT COMMENT 'Reference to the faculty member or subject librarian responsible for managing this fund and making acquisition decisions. Typically a liaison librarian for a specific academic discipline.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The total budget amount allocated to this fund for the fiscal year. Represents the initial funding available before any commitments or expenditures.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether purchases from this fund require additional administrative approval beyond the fund owner. True if approval workflow is required; False if fund owner has full discretion.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which purchases from this fund require additional approval. Null if no threshold applies or if approval_required_flag is False.',
    `available_balance` DECIMAL(18,2) COMMENT 'The remaining unencumbered and unexpended balance available for new commitments. Calculated as allocated_amount minus encumbered_amount minus expended_amount.',
    `cost_center` STRING COMMENT 'The institutional cost center or budget unit code for financial tracking and reporting. Links library fund to broader university budget structure.. Valid values are `^[A-Z0-9]{3,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fund record was first created in the library system. Audit trail for fund establishment.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this fund (e.g., USD, EUR, GBP). Supports multi-currency library budgets.. Valid values are `^[A-Z]{3}$`',
    `encumbered_amount` DECIMAL(18,2) COMMENT 'The total amount committed to purchase orders and subscriptions but not yet expended. Represents funds reserved for pending acquisitions.',
    `end_date` DATE COMMENT 'The date this fund expires or is scheduled to close. Null for perpetual funds such as endowments. For annual funds, typically the end of the fiscal year.',
    `expended_amount` DECIMAL(18,2) COMMENT 'The total amount actually spent from this fund to date. Represents invoices paid and completed transactions.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this fund allocation applies, represented as a four-digit year (e.g., 2024). Aligns with institutional fiscal calendar.. Valid values are `^[0-9]{4}$`',
    `fund_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying this fund within the library budget structure. Used for acquisitions tracking and financial reporting.. Valid values are `^[A-Z0-9]{3,20}$`',
    `fund_name` STRING COMMENT 'The human-readable descriptive name of the library fund (e.g., Science Monographs Fund, Humanities Serials Fund).',
    `fund_source` STRING COMMENT 'The origin of the funding for this library fund. Institutional funds come from general university budget; endowment funds are from invested principal; grant funds are from external research or program grants; donation/gift funds are from philanthropic contributions; state/federal funds are from government appropriations. [ENUM-REF-CANDIDATE: institutional|endowment|grant|donation|gift|state|federal — 7 candidates stripped; promote to reference product]',
    `fund_status` STRING COMMENT 'Current operational status of the fund in its lifecycle. Active funds are available for use; inactive funds are temporarily unavailable; closed funds are permanently retired; frozen funds are locked pending review; pending funds are awaiting approval.. Valid values are `active|inactive|closed|frozen|pending`',
    `fund_type` STRING COMMENT 'Classification of the fund based on its financial status and usage restrictions. Allocated funds are budgeted but not yet committed; encumbered funds are committed to orders; expended funds are fully spent; restricted funds have donor or grant limitations; unrestricted funds have no usage constraints; endowment funds are perpetual with spending rules.. Valid values are `allocated|encumbered|expended|restricted|unrestricted|endowment`',
    `last_modified_by` STRING COMMENT 'The username or identifier of the library staff member who most recently modified this fund record. Audit trail for change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fund record was most recently updated. Tracks the currency of fund data.',
    `material_type` STRING COMMENT 'The type of library materials this fund is designated to purchase. Books include monographs and textbooks; serials include journals and periodicals; electronic resources include e-books and e-journals; databases include subscription research platforms; multimedia includes audio/video materials; archives include special collections; all indicates no material type restriction. [ENUM-REF-CANDIDATE: books|serials|electronic_resources|databases|multimedia|archives|all — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or historical context about this fund. Used by librarians for fund management documentation.',
    `oer_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fund may be used to support Open Educational Resources initiatives, including OER textbook adoption incentives and open access publishing fees. True if OER expenditures are permitted; False otherwise.',
    `restriction_description` STRING COMMENT 'Detailed narrative describing any donor-imposed or institutional restrictions on how this fund may be used (e.g., Must be used for rare book acquisitions in American History, Supports STEM Open Educational Resources only).',
    `restriction_type` STRING COMMENT 'The level of donor or institutional restrictions on fund usage. Unrestricted funds have no limitations; temporarily restricted funds have time-bound or purpose-bound constraints; permanently restricted funds (endowments) have perpetual principal preservation requirements.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `rollover_flag` BOOLEAN COMMENT 'Indicates whether unexpended balances from this fund automatically roll over to the next fiscal year (True) or revert to the institution (False). Critical for year-end budget planning.',
    `start_date` DATE COMMENT 'The date this fund became active and available for use. Typically aligns with the beginning of the fiscal year or the date of fund establishment.',
    `subject_area` STRING COMMENT 'The primary academic subject or discipline this fund supports (e.g., Life Sciences, Social Sciences, Engineering). Used for collection development analysis.',
    `created_by` STRING COMMENT 'The username or identifier of the library staff member who created this fund record. Audit trail for accountability.',
    CONSTRAINT pk_library_fund PRIMARY KEY(`library_fund_id`)
) COMMENT 'Library budget fund record used to allocate and track expenditures for acquisitions. Stores fund code, fund name, fund type (allocated, encumbered, expended), fiscal year, parent fund hierarchy, allocated amount, encumbered amount, expended amount, available balance, and fund owner (subject librarian). Sourced from Alma/Ex Libris fund management. Library-specific financial tracking distinct from the institutional finance domains general ledger.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`electronic_resource` (
    `electronic_resource_id` BIGINT COMMENT 'Unique identifier for the electronic resource record. Primary key for the electronic resource entity.',
    `ada_accommodation_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_accommodation. Business justification: Electronic resources must meet ADA accessibility standards. When accommodations require alternative formats (e.g., accessible PDFs, screen-reader-compatible versions), the accommodation record links t',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Electronic resources (EBSCO, ProQuest, JSTOR, etc.) are enterprise applications requiring IT management for SSO configuration, access entitlement provisioning, service outage tracking, and security co',
    `license_id` BIGINT COMMENT 'Reference identifier for the legal license agreement governing use of this electronic resource.',
    `access_model` STRING COMMENT 'Licensing model defining how many users can access the resource concurrently. DDA (Demand-Driven Acquisition) and PDA (Patron-Driven Acquisition) indicate usage-triggered purchase models.. Valid values are `unlimited|simultaneous_users|single_user|dda|pda`',
    `activation_status` STRING COMMENT 'Current lifecycle status of the electronic resource indicating whether it is available for patron access.. Valid values are `active|inactive|trial|pending_activation|cancelled`',
    `annual_cost` DECIMAL(18,2) COMMENT 'Total annual cost of the electronic resource subscription in the institutions base currency. Used for budget planning and cost-per-use analysis.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the subscription automatically renews unless explicitly cancelled by the institution.',
    `cancellation_deadline` DATE COMMENT 'Last date by which the institution must notify the provider to cancel the subscription without penalty or auto-renewal.',
    `counter_compliant_flag` BOOLEAN COMMENT 'Indicates whether the provider supplies usage statistics that comply with COUNTER Code of Practice standards for consistent reporting.',
    `course_reserves_permitted_flag` BOOLEAN COMMENT 'Indicates whether the license agreement permits placing content on electronic course reserves for instructional use.',
    `coverage_end_date` DATE COMMENT 'Latest date of content coverage available in the electronic resource. Null for current subscriptions with ongoing coverage.',
    `coverage_start_date` DATE COMMENT 'Earliest date of content coverage available in the electronic resource (e.g., journal backfile start year).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic resource record was first created in the library system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the subscription cost (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `interlibrary_loan_permitted_flag` BOOLEAN COMMENT 'Indicates whether the license agreement permits sharing content via interlibrary loan services.',
    `internal_notes` STRING COMMENT 'Staff-only notes for collection management, troubleshooting, or renewal decision documentation.',
    `knowledge_base_code` STRING COMMENT 'Identifier linking this electronic resource to the librarys knowledge base portfolio for discovery and link resolution services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic resource record was most recently updated.',
    `last_usage_harvest_timestamp` TIMESTAMP COMMENT 'Date and time when usage statistics were most recently retrieved from the provider via SUSHI or manual upload.',
    `marc_record_available_flag` BOOLEAN COMMENT 'Indicates whether the provider supplies MARC records for catalog integration and discovery.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether this electronic resource is an open educational resource freely available without subscription cost.',
    `perpetual_access_rights_flag` BOOLEAN COMMENT 'Indicates whether the institution retains permanent access rights to subscribed content after subscription cancellation.',
    `provider_name` STRING COMMENT 'Name of the vendor or publisher providing the electronic resource (e.g., EBSCO, Elsevier, Gale).',
    `proxy_enabled_flag` BOOLEAN COMMENT 'Indicates whether off-campus access is enabled through the institutional proxy server (e.g., EZproxy).',
    `public_notes` STRING COMMENT 'Patron-facing notes about the electronic resource displayed in the library catalog or discovery interface (e.g., access instructions, coverage notes).',
    `renewal_date` DATE COMMENT 'Target date for subscription renewal decision and processing.',
    `resource_code` STRING COMMENT 'Internal institutional code or identifier for the electronic resource used for cataloging and reporting purposes.',
    `resource_name` STRING COMMENT 'The full title or name of the electronic resource (e.g., JSTOR, ScienceDirect, ProQuest Dissertations).',
    `resource_type` STRING COMMENT 'Classification of the electronic resource by content format and delivery model.. Valid values are `database|e-journal_package|e-book_collection|streaming_media|reference_tool|data_repository`',
    `simultaneous_user_limit` STRING COMMENT 'Maximum number of concurrent users allowed under the license agreement. Null if access model is unlimited.',
    `subject_area` STRING COMMENT 'Primary academic discipline or subject classification for the electronic resource content (e.g., STEM, Social Sciences, Humanities).',
    `subscription_end_date` DATE COMMENT 'Date when the current subscription term expires. Used for renewal planning and access cutoff.',
    `subscription_start_date` DATE COMMENT 'Date when the institutional subscription to this electronic resource became active.',
    `subscription_type` STRING COMMENT 'Format and delivery model of the subscription indicating whether content is digital, physical, or combined.. Valid values are `online_only|print_plus_online|print_only|perpetual_access|open_access`',
    `sushi_enabled_flag` BOOLEAN COMMENT 'Indicates whether usage statistics can be automatically harvested via the SUSHI protocol for automated reporting.',
    `sushi_service_url` STRING COMMENT 'Web service endpoint URL for automated SUSHI usage statistics retrieval.',
    `trial_end_date` DATE COMMENT 'Date when the trial access period expires. Null if not a trial resource.',
    `trial_flag` BOOLEAN COMMENT 'Indicates whether this electronic resource is currently in a trial evaluation period before purchase decision.',
    `trial_start_date` DATE COMMENT 'Date when the trial access period began. Null if not a trial resource.',
    CONSTRAINT pk_electronic_resource PRIMARY KEY(`electronic_resource_id`)
) COMMENT 'Electronic resource master record representing a licensed database, e-journal package, e-book collection, or streaming media service, including its subscription lifecycle and usage metrics. Stores resource name, resource type, provider, platform URL, coverage dates, access model (simultaneous users, unlimited, DDA), activation status, proxy configuration, subscription type (print, online, combined), annual cost, renewal date, auto-renewal flag, cancellation deadline, COUNTER-compliant usage statistics (metric type, reporting period, total/unique requests), and knowledge base portfolio membership. Sourced from Alma/Ex Libris electronic resource management (ERM) and serials modules, with usage data harvested via SUSHI protocol. Drives cost-per-use analysis, renewal decisions, and collection development.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`license` (
    `license_id` BIGINT COMMENT 'Unique identifier for the electronic resource license agreement record. Primary key.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Electronic resource licenses must comply with ADA accessibility, copyright law, and state authorization requirements. License review workflow verifies compliance with regulatory requirements before ex',
    `archival_rights_flag` BOOLEAN COMMENT 'Indicates whether the institution has the right to create and maintain a local archive of the licensed content for preservation purposes. True if archival rights are granted, false otherwise.',
    `authorized_users_definition` STRING COMMENT 'Textual definition of who is authorized to use the licensed resource, such as current students, faculty, staff, walk-in users, or alumni. Defines the scope of permitted user population.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the license agreement automatically renews at the end of the term unless cancelled. True if auto-renewal is enabled, false otherwise.',
    `concurrent_user_limit` STRING COMMENT 'Maximum number of simultaneous users allowed to access the licensed resource at one time. Null indicates unlimited concurrent access.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the license agreement includes a confidentiality clause restricting disclosure of license terms. True if confidentiality is required, false if terms can be shared publicly.',
    `course_reserve_allowed_flag` BOOLEAN COMMENT 'Indicates whether content from the licensed resource can be placed on electronic course reserves for students. True if course reserve use is permitted, false if prohibited.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the license record was first created in the system. Audit field for data lineage and compliance tracking.',
    `document_url` STRING COMMENT 'URL or file path reference to the full license agreement document stored in the document management system or shared drive.. Valid values are `^https?://.*$`',
    `effective_date` DATE COMMENT 'Date when the license agreement becomes active and usage rights begin. This is the start date of the license term.',
    `expiration_date` DATE COMMENT 'Date when the license agreement expires and usage rights end. Nullable for perpetual licenses or open-ended agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the license agreement, typically a state or country.',
    `ill_allowed_flag` BOOLEAN COMMENT 'Indicates whether content from the licensed resource can be provided to other libraries via interlibrary loan. True if ILL is permitted, false if prohibited.',
    `ill_electronic_delivery_flag` BOOLEAN COMMENT 'Indicates whether ILL content can be delivered electronically (e.g., via email or Ariel) or must be delivered in print only. True if electronic delivery is allowed, false if print only.',
    `indemnification_clause_flag` BOOLEAN COMMENT 'Indicates whether the license includes an indemnification clause where the licensor agrees to defend the institution against copyright infringement claims. True if indemnification is provided, false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the license record was last updated in the system. Audit field for change tracking and data quality monitoring.',
    `license_code` STRING COMMENT 'Business identifier code for the license agreement, typically assigned by the library or vendor. Used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `license_name` STRING COMMENT 'Human-readable name or title of the license agreement, typically reflecting the resource or vendor name.',
    `license_status` STRING COMMENT 'Current lifecycle status of the license agreement. Draft licenses are being prepared, active licenses are in effect, expired licenses have passed their end date, terminated licenses were cancelled early, suspended licenses are temporarily inactive, and under_review licenses are being evaluated for renewal or changes.. Valid values are `draft|active|expired|terminated|suspended|under_review`',
    `license_type` STRING COMMENT 'Classification of the license agreement type. Standard licenses use vendor templates, negotiated licenses have custom terms, open access licenses have no usage restrictions, trial licenses are temporary evaluation agreements, consortium licenses cover multiple institutions, and custom licenses have unique terms.. Valid values are `standard|negotiated|open_access|trial|consortium|custom`',
    `licensor_contact_email` STRING COMMENT 'Primary email address for the licensor contact person responsible for license administration and support.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `licensor_name` STRING COMMENT 'Name of the vendor, publisher, or organization granting the license rights for the electronic resource.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or internal comments about the license agreement that do not fit in structured fields.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required to cancel or modify the license agreement before renewal. Common values are 30, 60, or 90 days.',
    `perpetual_access_coverage` STRING COMMENT 'Description of the content covered by perpetual access rights, such as specific years, volumes, or content types. Relevant only when perpetual_access_rights_flag is true.',
    `perpetual_access_rights_flag` BOOLEAN COMMENT 'Indicates whether the institution retains permanent access rights to content purchased or subscribed during the license term, even after the license expires. True if perpetual access is granted, false if access ends with the license.',
    `remote_access_allowed_flag` BOOLEAN COMMENT 'Indicates whether authorized users can access the resource remotely (off-campus) via proxy, VPN, or authentication. True if remote access is permitted, false if access is restricted to on-campus only.',
    `renewal_date` DATE COMMENT 'Date by which the license must be renewed to continue access. Typically precedes the expiration date to allow for administrative processing time.',
    `review_date` DATE COMMENT 'Date when the license agreement was last reviewed by library staff or legal counsel for compliance and terms assessment.',
    `scholarly_sharing_allowed_flag` BOOLEAN COMMENT 'Indicates whether authorized users can share content for scholarly, educational, or research purposes with colleagues. True if scholarly sharing is permitted, false if prohibited.',
    `text_data_mining_allowed_flag` BOOLEAN COMMENT 'Indicates whether authorized users can perform text and data mining, computational analysis, or machine learning on the licensed content. True if TDM is permitted, false if prohibited.',
    `usage_statistics_format` STRING COMMENT 'Format or standard in which usage statistics are provided, such as COUNTER Release 5, COUNTER Release 4, or vendor-specific format. Relevant only when usage_statistics_provided_flag is true. [ENUM-REF-CANDIDATE: counter_r5|counter_r4|sushi|vendor_specific|excel|csv|pdf — promote to reference product]',
    `usage_statistics_provided_flag` BOOLEAN COMMENT 'Indicates whether the licensor provides usage statistics for the resource. True if statistics are provided, false if not available.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'Electronic resource license agreement record governing the terms of use for a licensed database or e-resource. Tracks licensor, license type (standard, negotiated, open access), effective date, expiration date, renewal date, permitted uses (ILL allowed, course reserve allowed, remote access allowed), concurrent user limit, perpetual access rights, and license document reference. Sourced from Alma/Ex Libris license management module.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`course_reserve` (
    `course_reserve_id` BIGINT COMMENT 'Unique identifier for the course reserve record. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Course reserves require copyright policy compliance (TEACH Act, fair use). Copyright clearance workflow references institutional copyright policy to determine permissible use, scanning limits, and att',
    `course_section_id` BIGINT COMMENT 'Identifier of the course section for which this reserve is created. Links to the academic course section in the Student Information System (SIS).',
    `electronic_resource_id` BIGINT COMMENT 'Identifier of the electronic resource (e-book, e-journal, database article) linked to this reserve. Populated for electronic reserves.',
    `employee_id` BIGINT COMMENT 'Identifier of the library staff member who processed and activated this course reserve.',
    `instructor_id` BIGINT COMMENT 'Identifier of the faculty member or instructor who requested the course reserve.',
    `item_id` BIGINT COMMENT 'Identifier of the physical library item (book, journal, media) placed on reserve. Populated for physical and digitized reserves. Links to library catalog item record.',
    `lms_course_shell_id` BIGINT COMMENT 'The unique identifier of the course in the Learning Management System (Canvas) where this reserve is linked.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to student.profile. Business justification: Course reserves track which student requested materials for copyright compliance (fair use documentation), usage analytics, and student billing when applicable. Essential for TEACH Act compliance and ',
    `access_url` STRING COMMENT 'The URL where students can access the electronic or digitized reserve material. May link to library proxy server, Learning Management System (LMS), or publisher platform.',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether the reserve material meets accessibility standards for students with disabilities (e.g., screen reader compatible, captioned video, alternative format available). True if compliant, False otherwise.',
    `activation_date` DATE COMMENT 'The date when the reserve becomes available to students. Typically aligns with course start date or when copyright clearance is obtained.',
    `alternative_format_available_flag` BOOLEAN COMMENT 'Indicates whether an alternative format (audio, large print, Braille) of this reserve is available for students with documented disabilities. True if available, False otherwise.',
    `citation_text` STRING COMMENT 'Full bibliographic citation for the reserve material (author, title, publisher, year, pages). Used for all reserve types to provide students with complete reference information.',
    `copyright_clearance_date` DATE COMMENT 'The date when copyright clearance was obtained or fair use determination was made.',
    `copyright_clearance_status` STRING COMMENT 'Status of copyright clearance for digitized or electronic reserves: cleared (permission obtained from rights holder), pending (clearance in progress), not_required (public domain or library-owned), denied (permission refused), fair_use (qualifies under Section 107 of U.S. Copyright Act).. Valid values are `cleared|pending|not_required|denied|fair_use`',
    `copyright_notes` STRING COMMENT 'Additional notes regarding copyright clearance, including rights holder information, permissions obtained, or fair use justification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this course reserve record was first created in the system.',
    `expiration_date` DATE COMMENT 'The date when the reserve is no longer available to students. Typically aligns with course end date or end of academic term.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this course reserve record was last updated or modified.',
    `last_usage_date` DATE COMMENT 'The most recent date when a student accessed or checked out this reserve material.',
    `lms_integration_flag` BOOLEAN COMMENT 'Indicates whether this reserve is integrated with the Learning Management System (Canvas) course site. True if the reserve link is embedded in the LMS course, False otherwise.',
    `loan_period_hours` STRING COMMENT 'The number of hours a physical reserve item may be checked out by a student. Common values include 2-hour, 4-hour, 24-hour, or 3-day reserves.',
    `notes` STRING COMMENT 'Additional notes or instructions regarding the course reserve, including special handling requirements, instructor preferences, or student access restrictions.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether this reserve material is an Open Educational Resource (OER) - freely accessible, openly licensed educational content. True if OER, False otherwise. Supports institutional OER adoption tracking.',
    `processing_date` DATE COMMENT 'The date when library staff completed processing and activated the reserve for student access.',
    `request_date` DATE COMMENT 'The date when the instructor submitted the course reserve request to the library.',
    `reserve_status` STRING COMMENT 'Current lifecycle status of the course reserve: active (available to students), pending (awaiting processing or copyright clearance), expired (term ended), cancelled (instructor withdrew request), processing (being prepared by library staff).. Valid values are `active|pending|expired|cancelled|processing`',
    `reserve_type` STRING COMMENT 'The type of reserve material: physical (print book/journal held at reserve desk), electronic (licensed e-resource link), digitized (scanned chapter/article under fair use or copyright clearance), streaming_media (video/audio), or citation_only (reference without direct access).. Valid values are `physical|electronic|digitized|streaming_media|citation_only`',
    `term_code` STRING COMMENT 'The academic term code for which this reserve is active (e.g., 202401 for Spring 2024, 202408 for Fall 2024).',
    `usage_count` STRING COMMENT 'The total number of times this reserve has been accessed or checked out by students during the active period. Used for collection development and instructional support assessment.',
    CONSTRAINT pk_course_reserve PRIMARY KEY(`course_reserve_id`)
) COMMENT 'Course reserve record linking library materials (physical or electronic) to a specific course section for instructional use. Tracks course identifier, instructor, term, reserve type (physical, electronic, digitized), item or electronic resource linked, activation date, expiration date, copyright clearance status, and usage count. Sourced from Alma/Ex Libris course reserves module. Supports teaching and instruction delivery across the institution.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`oer_resource` (
    `oer_resource_id` BIGINT COMMENT 'Unique identifier for the Open Educational Resource record in the library system.',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Faculty with PI status author OER materials. Real business process: faculty activity reporting, tenure/promotion dossiers, institutional OER adoption metrics, research-teaching integration tracking. E',
    `coa_budget_id` BIGINT COMMENT 'Foreign key linking to aid.coa_budget. Business justification: OER adoption directly reduces books/supplies component in COA budgets. Financial aid offices track which courses use OER to justify lower COA amounts in federal aid packaging, increasing Pell eligibil',
    `accreditation_standard_id` BIGINT COMMENT 'Foreign key linking to compliance.accreditation_standard. Business justification: OER adoption is tracked as evidence for accreditation standards related to affordability, student success, and educational innovation. Accreditation self-studies cite OER adoption rates and cost savin',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Tracks term-specific OER adoption at section level for cost savings reporting, accreditation documentation, and Title IV textbook affordability compliance. Library already tracks course_id (curriculum',
    `digital_object_id` BIGINT COMMENT 'Foreign key linking to library.digital_object. Business justification: library_oer_resource tracks OER (Open Educational Resource) adoption and has repository_identifier field. digital_object represents institutionally managed digital assets including OER materials (has ',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: OER development is often grant-funded (Department of Education, foundations). Grant reporting requires documenting OER outputs, student cost savings achieved, adoption metrics, and deliverables tied t',
    `lms_course_shell_id` BIGINT COMMENT 'Foreign key linking to instruction.lms_course_shell. Business justification: Links OER resources to Canvas/LMS course shells for usage analytics, accessibility compliance tracking, and integration with LMS assignment workflows. Enables librarians to verify OER deployment in ac',
    `course_id` BIGINT COMMENT 'Unique identifier of the course in which the OER is being used or adopted.',
    `instructor_id` BIGINT COMMENT 'Unique identifier of the faculty member who adopted or is using the OER in their course.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: OER development is often grant-funded through federal or foundation awards. Real business process: grant reporting requirements, cost savings attribution for sponsored projects, compliance with open a',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: OER resources are adopted for sport-specific academic programs (kinesiology, sports management, coaching theory). Tracking OER adoption by sport enables cost savings analysis and Title IX equity repor',
    `academic_term` STRING COMMENT 'The academic term or semester when the OER was first adopted or is currently in use (e.g., Fall 2023, Spring 2024).',
    `accessibility_compliance_flag` BOOLEAN COMMENT 'Indicates whether the OER meets institutional accessibility standards and ADA compliance requirements (True/False).',
    `accessibility_notes` STRING COMMENT 'Additional notes or details regarding the accessibility features or limitations of the OER.',
    `adoption_date` DATE COMMENT 'The date when the OER was officially adopted for use in institutional courses.',
    `adoption_status` STRING COMMENT 'The current adoption status of the OER within the institution (e.g., adopted for courses, under review, recommended).. Valid values are `Adopted|Under Review|Recommended|Not Adopted|Retired`',
    `alternate_url` STRING COMMENT 'Secondary or mirror URL for accessing the OER, if available.. Valid values are `^https?://.*$`',
    `author_creator` STRING COMMENT 'The name(s) of the individual(s) or organization(s) who authored or created the OER.',
    `cip_code` STRING COMMENT 'The six-digit CIP code aligning the OER to a specific instructional program classification.. Valid values are `^d{2}.d{4}$`',
    `cip_title` STRING COMMENT 'The descriptive title corresponding to the CIP code for the instructional program.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the OER record was first created in the library system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for cost savings calculations (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `edition` STRING COMMENT 'The edition or version number of the OER, if applicable.',
    `estimated_cost_savings_per_student` DECIMAL(18,2) COMMENT 'The estimated cost savings per student resulting from the use of the OER instead of traditional textbooks or materials.',
    `estimated_student_count` STRING COMMENT 'The estimated number of students who will use or have used the OER in the associated course.',
    `institutional_repository_flag` BOOLEAN COMMENT 'Indicates whether the OER is hosted in the institutions own digital repository (True/False).',
    `keywords` STRING COMMENT 'Comma-separated list of keywords or tags describing the OER content for discovery and search purposes.',
    `language` STRING COMMENT 'The primary language of the OER content, represented as an ISO 639 language code.. Valid values are `^[a-z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the OER record was last updated or modified in the library system.',
    `license_type` STRING COMMENT 'The Creative Commons or open license type governing the use and distribution of the OER.. Valid values are `CC-BY|CC-BY-SA|CC-BY-NC|CC-BY-NC-SA|CC0|Public Domain`',
    `license_url` STRING COMMENT 'The web address linking to the full text of the license governing the OER.. Valid values are `^https?://.*$`',
    `license_version` STRING COMMENT 'The version number of the Creative Commons or open license (e.g., 4.0, 3.0).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the OER, its use, or special considerations.',
    `publication_date` DATE COMMENT 'The date when the OER was originally published or made available.',
    `publisher` STRING COMMENT 'The name of the organization or entity that published or hosts the OER.',
    `quality_rating` DECIMAL(18,2) COMMENT 'The quality rating assigned to the OER during review, typically on a scale (e.g., 1.00 to 5.00).',
    `resource_description` STRING COMMENT 'Detailed description of the OER content, scope, and learning objectives.',
    `resource_format` STRING COMMENT 'The primary format or media type of the OER (e.g., PDF, HTML, video, interactive module). [ENUM-REF-CANDIDATE: PDF|HTML|ePub|Video|Interactive|Audio|Textbook|Course Module|Simulation|Assessment — 10 candidates stripped; promote to reference product]',
    `resource_subtitle` STRING COMMENT 'The subtitle or secondary title of the OER, if applicable.',
    `resource_title` STRING COMMENT 'The full title of the Open Educational Resource as cataloged in the library system.',
    `resource_url` STRING COMMENT 'The primary web address where the OER can be accessed online.. Valid values are `^https?://.*$`',
    `review_date` DATE COMMENT 'The date when the OER was last reviewed for quality, accuracy, and alignment with institutional standards.',
    `review_status` STRING COMMENT 'The current review status of the OER by institutional faculty or library staff for quality and appropriateness.. Valid values are `Not Reviewed|Under Review|Reviewed|Approved|Rejected`',
    `reviewer_name` STRING COMMENT 'The name of the faculty member or librarian who conducted the quality review of the OER.',
    `subject_area` STRING COMMENT 'The primary academic subject or discipline area covered by the OER (e.g., Mathematics, Biology, History).',
    `total_estimated_cost_savings` DECIMAL(18,2) COMMENT 'The total estimated cost savings for all students using the OER, calculated as cost savings per student multiplied by student count.',
    CONSTRAINT pk_oer_resource PRIMARY KEY(`oer_resource_id`)
) COMMENT 'Open Educational Resource (OER) record tracking openly licensed learning materials adopted, created, or curated by the institution. Stores OER title, subject area, CIP code alignment, license type (CC-BY, CC-BY-SA, public domain), format, URL, adoption status, adopting faculty member, associated course, estimated student cost savings, and review status. Supports institutional OER initiatives and affordability reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`digital_object` (
    `digital_object_id` BIGINT COMMENT 'Unique identifier for the digital repository object record. Primary key for the digital_object product.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Digital repository objects must comply with institutional policies on access rights, embargoes, copyright, and data retention. Embargo enforcement and open access mandate compliance depend on linking ',
    `profile_id` BIGINT COMMENT 'Foreign key linking to student.profile. Business justification: Institutional repository requires formal attribution of student-authored works (theses, dissertations, capstone projects) to official academic record for degree conferral verification, embargo managem',
    `collection_id` BIGINT COMMENT 'Reference to the institutional repository collection or special collection to which this digital object belongs.',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: Faculty deposit scholarly works, datasets, and creative outputs into institutional repositories. Linking digital_object to instructor as creator enables attribution reporting, open access mandate comp',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Digital repository objects (theses, datasets, publications) often result from grant-funded research. Grant compliance reporting, acknowledgment requirements, NIH public access mandates, and open acces',
    `instruction_assignment_id` BIGINT COMMENT 'Foreign key linking to instruction.assignment. Business justification: Links institutional repository deposits (theses, capstone projects, dissertations) to originating course assignments for provenance tracking, academic integrity verification, and ETD workflow manageme',
    `patron_id` BIGINT COMMENT 'Reference to the faculty, student, or institutional author who created or contributed this digital object.',
    `abstract` STRING COMMENT 'Summary or abstract describing the content, scope, and purpose of the digital object.',
    `academic_department` STRING COMMENT 'Name of the academic department, school, or college associated with the creator or content of the digital object (e.g., Department of Biology, College of Engineering).',
    `access_rights` STRING COMMENT 'Current access level for the digital object: open access (publicly available), campus only (institutional authentication required), restricted (permission required), embargoed (temporarily restricted), or dark archive (preservation only, no access).. Valid values are `open_access|campus_only|restricted|embargoed|dark_archive`',
    `checksum` STRING COMMENT 'Cryptographic hash (e.g., MD5, SHA-256) of the digital object file, used for fixity checking and ensuring file integrity over time.',
    `contributor_names` STRING COMMENT 'Semicolon-separated list of additional contributors, co-authors, advisors, or collaborators associated with the digital object.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital object record was first created in the repository system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `degree_level` STRING COMMENT 'Academic level of the degree associated with this digital object: bachelors, masters, doctoral, or post-doctoral. Relevant for theses and dissertations.. Valid values are `bachelors|masters|doctoral|post_doctoral`',
    `degree_name` STRING COMMENT 'Name of the academic degree associated with this digital object, if applicable (e.g., Master of Science, Doctor of Philosophy). Relevant for theses and dissertations.',
    `deposit_date` DATE COMMENT 'Date when the digital object was deposited into the institutional repository, in yyyy-MM-dd format.',
    `doi` STRING COMMENT 'Digital Object Identifier (DOI) assigned to this object for permanent citation and linking, following the DOI naming convention (e.g., 10.1234/example).. Valid values are `^10.d{4,9}/[-._;()/:A-Za-z0-9]+$`',
    `download_count` BIGINT COMMENT 'Cumulative number of times this digital object has been downloaded or accessed by users. Used for usage analytics and impact assessment.',
    `embargo_end_date` DATE COMMENT 'Date when any access embargo or restriction period expires and the object becomes publicly accessible, in yyyy-MM-dd format. Null if no embargo applies.',
    `estimated_student_savings_usd` DECIMAL(18,2) COMMENT 'Estimated total cost savings to students (in USD) resulting from adoption of this Open Educational Resource (OER) in place of commercial textbooks. Supports institutional affordability reporting.',
    `file_format` STRING COMMENT 'Primary file format or MIME type of the digital object (e.g., PDF, DOCX, HTML, MP4, JPEG, TIFF, CSV). Supports preservation planning and access workflows. [ENUM-REF-CANDIDATE: pdf|docx|html|xml|mp4|mp3|jpg|png|tiff|csv|zip — 11 candidates stripped; promote to reference product]',
    `file_size_bytes` BIGINT COMMENT 'Total size of the digital object file(s) in bytes. Used for storage planning, bandwidth estimation, and preservation costing.',
    `graduation_year` STRING COMMENT 'Year in which the degree associated with this digital object was conferred. Relevant for theses and dissertations.',
    `handle` STRING COMMENT 'Handle System persistent identifier assigned to this digital object, commonly used in institutional repositories (e.g., hdl:1234.5/6789).',
    `language` STRING COMMENT 'Primary language of the digital object content, using ISO 639-3 three-letter language codes (e.g., eng for English, spa for Spanish). [ENUM-REF-CANDIDATE: eng|spa|fra|deu|zho|ara|jpn|rus|por|ita — 10 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital object record was most recently updated or modified in the repository system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `last_preservation_check_date` DATE COMMENT 'Date when the most recent digital preservation fixity check or integrity audit was performed on this object, in yyyy-MM-dd format.',
    `license_type` STRING COMMENT 'Intellectual property license governing use and redistribution of the digital object. Includes Creative Commons variants (CC BY, CC BY-SA, CC BY-NC, CC BY-ND, CC0) commonly used for Open Educational Resources (OER), or all rights reserved for traditional copyright.. Valid values are `cc_by|cc_by_sa|cc_by_nc|cc_by_nd|cc0|all_rights_reserved`',
    `notes` STRING COMMENT 'Free-text field for internal administrative notes, cataloging comments, or special handling instructions related to this digital object.',
    `object_type` STRING COMMENT 'Classification of the digital object by content type: thesis, dissertation, faculty publication, digitized special collection item, Open Educational Resource (OER), research dataset, or other institutional repository deposit.. Valid values are `thesis|dissertation|faculty_publication|digitized_collection|oer|dataset`',
    `oer_adoption_status` STRING COMMENT 'Current adoption status of this Open Educational Resource (OER) in institutional courses: not adopted, pilot (trial use), adopted (active use), or retired (no longer in use).. Valid values are `not_adopted|pilot|adopted|retired`',
    `oer_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this digital object is classified as an Open Educational Resource (OER) available for adoption in courses to reduce student textbook costs.',
    `open_access_mandate_compliance` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this digital object complies with institutional, funder, or governmental open access mandates (e.g., NIH Public Access Policy, NSF data sharing requirements).',
    `peer_reviewed_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this digital object has undergone formal peer review prior to publication. Relevant for faculty publications and scholarly works.',
    `persistent_identifier` STRING COMMENT 'Globally unique and persistent identifier for the digital object, typically a Digital Object Identifier (DOI) or Handle, ensuring long-term discoverability and citation stability.',
    `preservation_status` STRING COMMENT 'Current digital preservation status of the object: active (regularly maintained), archived (long-term storage), at risk (format or media degradation concern), or obsolete (no longer accessible).. Valid values are `active|archived|at_risk|obsolete`',
    `publication_date` DATE COMMENT 'Date when the digital object was originally published or made publicly available, in yyyy-MM-dd format.',
    `publisher` STRING COMMENT 'Name of the publisher or institutional entity responsible for making the digital object available (typically the university or repository name).',
    `subject_keywords` STRING COMMENT 'Semicolon-separated list of subject headings, keywords, or controlled vocabulary terms describing the content and topics of the digital object.',
    `subtitle` STRING COMMENT 'Secondary or explanatory title for the digital object, if applicable.',
    `title` STRING COMMENT 'The full title or name of the digital object as provided by the creator or cataloger.',
    `view_count` BIGINT COMMENT 'Cumulative number of times the metadata or landing page for this digital object has been viewed. Distinct from download count.',
    CONSTRAINT pk_digital_object PRIMARY KEY(`digital_object_id`)
) COMMENT 'Digital repository object record for institutionally managed digital assets including theses, dissertations, faculty publications, digitized special collections, institutional repository deposits, and Open Educational Resources (OER). Tracks object type, title, creator, deposit date, embargo end date, access rights, license type (including Creative Commons variants for OER), persistent identifier (DOI, handle), file format, file size, download count, collection membership, OER adoption status, and estimated student cost savings where applicable. Supports scholarly communication, open access mandates, and institutional OER affordability initiatives.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`collection` (
    `collection_id` BIGINT COMMENT 'Unique identifier for the library collection record. Primary key.',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Collections are often funded by donor gifts (collection.donor_funded_flag exists). Linking collection to donor enables Advancement to produce stewardship reports showing collection growth and impact f',
    `employee_id` BIGINT COMMENT 'Identifier of the subject librarian or bibliographer responsible for collection development, assessment, and liaison activities for this collection.',
    `library_fund_id` BIGINT COMMENT 'Foreign key linking to library.library_fund. Business justification: collection has acquisition_budget_code (STRING) that references library_fund. Business: collections have associated acquisition budgets (library funds) used to allocate and track expenditures for acqu',
    `sport_id` BIGINT COMMENT 'Foreign key linking to athletics.sport. Business justification: Athletic departments fund specialized library collections (sports medicine, coaching, athletic training). Collection development decisions, budget allocation, and Title IX equity analysis require trac',
    `accreditation_support_flag` BOOLEAN COMMENT 'Indicates whether this collection is specifically maintained to support institutional or program accreditation requirements (e.g., AACSB business collections, ABET engineering collections).',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Annual budget allocation in USD for acquiring new materials and maintaining subscriptions for this collection.',
    `annual_circulation_count` STRING COMMENT 'Total number of checkouts and renewals from this collection in the most recent fiscal year. Key performance indicator for collection usage.',
    `average_publication_year` STRING COMMENT 'Mean publication year of materials in the collection, used as an indicator of collection currency and age.',
    `cip_code` STRING COMMENT 'Six-digit CIP code representing the academic program or discipline this collection primarily supports. Used for IPEDS reporting and accreditation alignment.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `collection_code` STRING COMMENT 'Short alphanumeric code used to identify the collection in cataloging and acquisitions workflows. Must be unique within the institution.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `collection_name` STRING COMMENT 'Full descriptive name of the collection as displayed to patrons and staff.',
    `collection_status` STRING COMMENT 'Current lifecycle status of the collection. Active collections are being actively managed and acquired; inactive collections are no longer growing but retained; under review collections are being evaluated for retention or deselection; archived collections are preserved but not actively circulated; deaccessioned collections have been formally removed from holdings.. Valid values are `active|inactive|under_review|archived|deaccessioned`',
    `collection_type` STRING COMMENT 'Classification of the collection by its nature and management approach. General collections are circulating materials; special collections include rare books and manuscripts; archival collections are institutional records; digital collections are born-digital or digitized resources; OER (Open Educational Resources) are freely accessible teaching materials; reserve collections support specific courses.. Valid values are `general|special|archival|digital|oer|reserve`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection record was first created in the library management system.',
    `digital_access_flag` BOOLEAN COMMENT 'Indicates whether materials in this collection are accessible digitally (online, via institutional repository, or through licensed databases).',
    `donor_funded_flag` BOOLEAN COMMENT 'Indicates whether this collection is funded wholly or partially by donor contributions or endowments.',
    `duplication_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of titles in the collection that have multiple copies. Calculated as (titles with 2+ copies / total titles) * 100. Used to assess redundancy and space efficiency.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the library staff member who last modified this collection record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collection record was most recently updated.',
    `last_review_date` DATE COMMENT 'Date when the collection was last formally reviewed for quality, relevance, and alignment with institutional priorities. Used for accreditation and assessment cycles.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal collection review cycle.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, historical information, special handling instructions, or administrative details about the collection.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether this collection consists primarily of Open Educational Resources that are freely accessible and openly licensed for educational use.',
    `policy_url` STRING COMMENT 'URL reference to the formal collection development policy document that governs acquisition, retention, and deselection decisions for this collection.. Valid values are `^https?://.*$`',
    `primary_lc_class` STRING COMMENT 'Primary Library of Congress classification letter(s) representing the dominant subject area of the collection (e.g., Q for Science, H for Social Sciences, P for Language and Literature).. Valid values are `^[A-Z]{1,2}$`',
    `primary_location_code` STRING COMMENT 'Code representing the primary physical or virtual location where materials in this collection are housed or accessed (e.g., main library, branch library, digital repository).. Valid values are `^[A-Z0-9_-]{2,10}$`',
    `review_cycle_years` STRING COMMENT 'Number of years between formal collection reviews. Typically ranges from 3 to 7 years depending on collection type and institutional policy.',
    `special_access_required_flag` BOOLEAN COMMENT 'Indicates whether access to this collection requires special permissions, training, or supervised use (common for special collections, archives, and restricted materials).',
    `subject_scope` STRING COMMENT 'Narrative description of the subject areas, disciplines, and topical boundaries covered by this collection. Used for collection development policy and accreditation reporting.',
    `total_item_count` STRING COMMENT 'Total number of physical and digital items currently cataloged in this collection. Updated periodically from inventory systems.',
    `total_title_count` STRING COMMENT 'Total number of unique bibliographic titles in this collection, regardless of copy count or format.',
    `usage_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of items in the collection that circulated at least once in the most recent fiscal year. Calculated as (items circulated / total items) * 100.',
    `weeding_candidate_count` STRING COMMENT 'Number of items in the collection flagged as candidates for deselection or withdrawal based on age, condition, usage, and relevance criteria.',
    CONSTRAINT pk_collection PRIMARY KEY(`collection_id`)
) COMMENT 'Library collection master record defining a named grouping of materials managed as a unit for acquisition, assessment, and deselection purposes. Stores collection name, collection type (general, special, archival, digital, OER), subject scope, responsible subject librarian, location, collection policy document reference, last review date, and collection health indicators (age, usage rate, duplication rate). Supports collection development and accreditation reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`research_support_request` (
    `research_support_request_id` BIGINT COMMENT 'Unique identifier for the research support service request record.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Tracks course-integrated library instruction sessions (one-shots, embedded librarian support) for ACRL assessment, liaison workload reporting, and information literacy outcome mapping. Enables librari',
    `employee_id` BIGINT COMMENT 'Identifier of the librarian or research support specialist assigned to fulfill this request.',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Research support consultations (data management plans, systematic reviews, bibliometrics) often relate to specific grant projects. Grant activity tracking, service costing for indirect cost proposals,',
    `patron_id` BIGINT COMMENT 'Identifier of the patron (student, faculty, or staff) who submitted the research support request.',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to research.principal_investigator. Business justification: Library research support requests (literature reviews, data management plans, systematic reviews) are often submitted by principal investigators. This FK links library.research_support_request to the ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Research support consultations assist with regulatory compliance: IRB protocols, data management plans (NSF/NIH requirements), grant compliance, and open access mandates. Linking requests to requireme',
    `cancellation_reason` STRING COMMENT 'Reason provided for cancellation if the research support request was cancelled by the patron or librarian.',
    `cip_code` STRING COMMENT 'Standard CIP code representing the subject area or academic program related to the research support request.',
    `citation_style` STRING COMMENT 'Citation style format requested or used during citation management support (e.g., APA, MLA, Chicago).. Valid values are `APA|MLA|Chicago|IEEE|AMA|Harvard`',
    `completion_date` DATE COMMENT 'Date when the research support request was fulfilled and marked as complete.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the research support request record was first created in the system.',
    `data_management_plan_required` BOOLEAN COMMENT 'Indicates whether the research project requires a formal data management plan as part of grant or institutional requirements.',
    `duration_minutes` STRING COMMENT 'Total duration of the research support session or consultation in minutes.',
    `feedback_comments` STRING COMMENT 'Qualitative feedback provided by the patron regarding their experience with the research support service.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up consultation or communication if additional support is required.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up sessions or communications are needed to complete the research support request.',
    `grant_funded` BOOLEAN COMMENT 'Indicates whether the research project associated with this request is funded by an external grant (e.g., NSF, NIH).',
    `internal_notes` STRING COMMENT 'Internal staff notes for coordination, follow-up actions, or administrative purposes not shared with the patron.',
    `irb_protocol_number` STRING COMMENT 'IRB protocol number if the research involves human subjects and requires ethical review.',
    `last_modified_by` STRING COMMENT 'Identifier or username of the staff member who last modified the research support request record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the research support request record was last updated or modified.',
    `location` STRING COMMENT 'Physical location or virtual platform where the research support session took place (e.g., library room number, Zoom, email).',
    `open_educational_resource_flag` BOOLEAN COMMENT 'Indicates whether the research support request involves Open Educational Resources (OER) discovery or adoption.',
    `outcome_notes` STRING COMMENT 'Librarian notes documenting the services provided, resources shared, and outcomes of the research support session.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the research support request based on urgency and patron need.. Valid values are `low|medium|high|urgent`',
    `referral_source` STRING COMMENT 'Source through which the patron learned about or was referred to the research support service (e.g., faculty referral, library website, course instructor).',
    `request_date` DATE COMMENT 'Date when the research support request was submitted by the patron.',
    `request_description` STRING COMMENT 'Detailed description of the research support need as articulated by the patron at the time of request submission.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the research support request, used for tracking and reference.',
    `request_status` STRING COMMENT 'Current lifecycle status of the research support request.. Valid values are `submitted|assigned|in_progress|completed|cancelled|on_hold`',
    `requester_type` STRING COMMENT 'Classification of the patron submitting the request based on their institutional role.. Valid values are `undergraduate|graduate|faculty|staff|postdoc|visiting_scholar`',
    `research_project_title` STRING COMMENT 'Title of the research project or scholarly work for which the patron is seeking library support.',
    `resources_provided` STRING COMMENT 'List or description of library resources, databases, tools, or materials provided to the patron during the session.',
    `satisfaction_rating` STRING COMMENT 'Patron satisfaction rating for the research support service, typically on a scale of 1 to 5.',
    `scheduled_date` DATE COMMENT 'Date when the research support session or consultation is scheduled to occur.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when the scheduled research support session is set to begin.',
    `scholarly_communication_topic` STRING COMMENT 'Specific scholarly communication topic addressed in the session (e.g., open access publishing, copyright, author rights, research impact metrics).',
    `service_type` STRING COMMENT 'Category of research support service requested by the patron.. Valid values are `research_consultation|instruction_session|systematic_review_support|data_management_plan_review|citation_management|literature_search`',
    `session_format` STRING COMMENT 'Delivery mode for the research support service (in-person, virtual meeting, hybrid, or asynchronous communication).. Valid values are `in_person|virtual|hybrid|asynchronous`',
    `subject_area` STRING COMMENT 'Academic discipline or subject domain for which research support is requested (e.g., Biology, Engineering, Social Sciences).',
    CONSTRAINT pk_research_support_request PRIMARY KEY(`research_support_request_id`)
) COMMENT 'Library research support service request record capturing consultations, instruction sessions, literature searches, and data management assistance provided to faculty and students. Tracks requester type (student, faculty, staff), service type (research consultation, instruction session, systematic review support, data management plan review, citation management), subject area, librarian assigned, request date, completion date, duration, and outcome notes. Supports research domain integration.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`usage_stat` (
    `usage_stat_id` BIGINT COMMENT 'Unique identifier for the electronic resource usage statistic record.',
    `electronic_resource_id` BIGINT COMMENT 'Reference to the electronic resource (database, e-journal, e-book) being tracked. Links to the electronic resource catalog entry in Alma/Ex Libris.',
    `enterprise_application_id` BIGINT COMMENT 'Foreign key linking to technology.enterprise_application. Business justification: Usage statistics platforms (COUNTER/SUSHI endpoints) are enterprise applications requiring IT support for API integration, authentication, scheduled harvesting jobs, and data pipeline monitoring. Esse',
    `platform_id` BIGINT COMMENT 'Reference to the vendor platform providing the electronic resource (e.g., EBSCO, ProQuest, JSTOR). Links to platform registry.',
    `publisher_id` BIGINT COMMENT 'A standardized identifier for the publisher, such as ISNI (International Standard Name Identifier). Used for consistent publisher identification across platforms.',
    `access_method` STRING COMMENT 'Indicates whether usage was through regular human access or Text and Data Mining (TDM) automated access. Per COUNTER 5 access method classification.. Valid values are `Regular|TDM`',
    `access_type` STRING COMMENT 'Indicates whether the resource access is controlled (subscription-based), open access gold (freely available at publication), open access with embargo (delayed free access), or other free-to-read model. Per COUNTER 5 access type classification.. Valid values are `Controlled|OA_Gold|OA_Delayed|Other_Free_To_Read`',
    `cost_in_local_currency` DECIMAL(18,2) COMMENT 'The subscription or access cost for the resource during the reporting period, in the institutions local currency. Used for cost-per-use analysis and return on investment (ROI) calculations for renewal decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this usage statistic record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for data lineage and audit trails.',
    `data_source` STRING COMMENT 'The method by which the usage statistics were obtained. SUSHI indicates automated harvest, Manual_Upload indicates file upload by staff, Vendor_Portal indicates download from vendor website, Email indicates vendor-sent reports.. Valid values are `SUSHI|Manual_Upload|Vendor_Portal|Email`',
    `data_type` STRING COMMENT 'The type of content being measured. Per COUNTER 5 data type classification. Used to segment usage analysis by content format. [ENUM-REF-CANDIDATE: Book|Journal|Database|Multimedia|Repository_Item|Newspaper_or_Newsletter|Report|Conference|Thesis_or_Dissertation|Other — 10 candidates stripped; promote to reference product]',
    `doi` STRING COMMENT 'The DOI persistent identifier for the resource or item. Format: 10.xxxx/xxxxx. Used for item-level tracking and linking to publisher metadata.',
    `isbn` STRING COMMENT 'The ISBN identifier for book resources. May be ISBN-10 or ISBN-13 format. Used for book-level usage tracking and cost-per-use analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this usage statistic record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for change tracking and data quality monitoring.',
    `limit_exceeded_requests` BIGINT COMMENT 'The number of access denials due to usage limits (download caps, print limits) being exceeded during the reporting period. Per COUNTER 5 denial category.',
    `local_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the cost_in_local_currency field. Used for multi-currency cost tracking and reporting. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|JPY|CNY|INR — 8 candidates stripped; promote to reference product]',
    `metric_type` STRING COMMENT 'The COUNTER 5 metric type code indicating the type of usage being reported. TR=Title Report (books/journals), DR=Database Report, PR=Platform Report, IR=Item Report. Suffixes indicate specific metric variants (e.g., TR_B1 for book requests, DR_D1 for database searches). [ENUM-REF-CANDIDATE: TR_B1|TR_B2|TR_B3|TR_J1|TR_J2|TR_J3|TR_J4|DR_D1|DR_D2|PR_P1|IR_A1|IR_M1 — 12 candidates stripped; promote to reference product]',
    `no_license_requests` BIGINT COMMENT 'The number of access denials due to simultaneous user license limits being exceeded during the reporting period. Indicates unmet demand and potential need for additional licenses.',
    `notes` STRING COMMENT 'Free-text field for staff annotations regarding data quality issues, vendor reporting anomalies, platform changes, or other contextual information relevant to interpreting the usage statistics.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether the resource is classified as an Open Educational Resource (freely accessible educational content). True if OER, False if not. Used for OER usage tracking and institutional OER adoption metrics.',
    `online_issn` STRING COMMENT 'The ISSN identifier for the online version of a journal or serial. 8-digit format (XXXX-XXXX). Used for electronic journal usage tracking.',
    `parent_data_type` STRING COMMENT 'The data type of the parent publication. Used in conjunction with parent_title for hierarchical reporting.. Valid values are `Book|Journal|Database`',
    `parent_title` STRING COMMENT 'The title of the parent publication (journal title for an article, book title for a chapter). Used for hierarchical usage reporting.',
    `print_issn` STRING COMMENT 'The ISSN identifier for the print version of a journal or serial. 8-digit format (XXXX-XXXX). Used for journal-level usage tracking.',
    `proprietary_identifier` STRING COMMENT 'The vendor-specific identifier for the resource or item. Used when standard identifiers (ISBN, ISSN, DOI) are not available. Format varies by platform.',
    `publisher` STRING COMMENT 'The name of the publisher or content provider for the resource. Used for publisher-level usage aggregation and cost analysis.',
    `reporting_period_end_date` DATE COMMENT 'The last day of the reporting period for which usage statistics are aggregated. Typically monthly (last day of month) per COUNTER 5 standard.',
    `reporting_period_start_date` DATE COMMENT 'The first day of the reporting period for which usage statistics are aggregated. Typically monthly (first day of month) per COUNTER 5 standard.',
    `searches_automated` BIGINT COMMENT 'The number of automated searches executed by discovery services, link resolvers, or other automated systems during the reporting period. Reported separately from regular searches per COUNTER 5.',
    `searches_federated` BIGINT COMMENT 'The number of searches executed through federated search systems that query multiple resources simultaneously. Reported separately per COUNTER 5 to avoid double-counting.',
    `searches_regular` BIGINT COMMENT 'The number of searches (queries) executed on the platform during the reporting period, excluding automated and federated searches. Applicable to database and platform reports (DR, PR). Per COUNTER 5 search definition.',
    `section_type` STRING COMMENT 'The granular content type within a larger work (e.g., chapter within a book, article within a journal). Per COUNTER 5 section type attribute.. Valid values are `Article|Book|Chapter|Section|Other`',
    `sushi_harvest_date` DATE COMMENT 'The date when the usage statistics were harvested from the vendor platform via SUSHI automated retrieval protocol. Used for data freshness tracking and audit trails.',
    `total_item_investigations` BIGINT COMMENT 'The total number of user activities indicating interest in an item, including abstract views, table of contents views, and full-text requests. Broader measure than requests. Per COUNTER 5 investigation definition.',
    `total_item_requests` BIGINT COMMENT 'The total number of successful full-text article requests, book section views, or multimedia file accesses during the reporting period. Excludes failed requests and robot/crawler activity per COUNTER filtering rules.',
    `unique_item_investigations` BIGINT COMMENT 'The number of unique items investigated during the reporting period. Multiple investigations of the same item by the same user session are counted once. Per COUNTER 5 unique investigation definition.',
    `unique_item_requests` BIGINT COMMENT 'The number of unique items (articles, chapters, multimedia files) requested during the reporting period. Multiple requests for the same item by the same user session are counted once. Per COUNTER 5 unique item definition.',
    `unique_title_investigations` BIGINT COMMENT 'The number of unique titles for which at least one item was investigated during the reporting period. Used for title-level usage aggregation.',
    `unique_title_requests` BIGINT COMMENT 'The number of unique titles (journals, books, databases) for which at least one item was requested during the reporting period. Used for title-level usage aggregation.',
    `uri` STRING COMMENT 'The persistent URI or URL for the resource. Used for direct linking and resource identification when other identifiers are unavailable.',
    `yop` STRING COMMENT 'The publication year of the content accessed, used to analyze usage patterns by content age. May be a 4-digit year, a range (e.g., 2010-2015), or Articles in Press for pre-publication content. Per COUNTER 5 YOP attribute.',
    CONSTRAINT pk_usage_stat PRIMARY KEY(`usage_stat_id`)
) COMMENT 'Electronic resource usage statistics record capturing COUNTER-compliant access and download metrics for licensed databases, e-journals, and e-books. Stores resource identifier, reporting period, platform, metric type (TR_B1, DR_D1, PR_P1 per COUNTER 5), total requests, unique title requests, unique item requests, and data source. Sourced from vendor SUSHI harvests via Alma/Ex Libris analytics. Drives cost-per-use analysis and renewal decisions.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Unique identifier for the subscription record. Primary key for the subscription entity.',
    `electronic_resource_id` BIGINT COMMENT 'Foreign key linking to library.electronic_resource. Business justification: subscription contains electronic resource metadata (subscription_title, issn, e_issn, isbn, publisher_name, platform_name, access_url, proxy_enabled_flag, simultaneous_user_limit) that overlaps with e',
    `employee_id` BIGINT COMMENT 'Reference to the library staff member or faculty liaison responsible for selecting and managing this subscription.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Subscription expenditures post to GL accounts for financial reporting, budget tracking, and audit trails. Each subscription type (journals, databases, streaming media) maps to specific expense account',
    `library_fund_id` BIGINT COMMENT 'Reference to the library fund or budget code used to pay for this subscription.',
    `library_vendor_id` BIGINT COMMENT 'Reference to the vendor or publisher providing the subscription resource.',
    `license_id` BIGINT COMMENT 'Reference to the license agreement governing the legal terms of this subscription.',
    `access_verification_status` STRING COMMENT 'Status of the most recent access verification test to confirm that the subscription resource is accessible to patrons.. Valid values are `verified|failed|pending|not_tested`',
    `annual_cost` DECIMAL(18,2) COMMENT 'The annual subscription cost charged by the vendor.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the subscription automatically renews unless explicitly cancelled.',
    `cancellation_deadline` DATE COMMENT 'The last date by which the library must notify the vendor to cancel the subscription without penalty or automatic renewal.',
    `cancellation_reason` STRING COMMENT 'The reason for cancelling the subscription, if applicable. Used for collection development analysis.',
    `cancelled_date` DATE COMMENT 'The date when the subscription was cancelled. Null if the subscription is active or pending.',
    `collection_code` STRING COMMENT 'The library collection code or category to which this subscription is assigned for organizational and reporting purposes.',
    `coverage_end_date` DATE COMMENT 'The date when subscription coverage ends. Null for perpetual access or open-ended subscriptions.',
    `coverage_start_date` DATE COMMENT 'The date when subscription coverage begins, representing the earliest content accessible under this agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the subscription record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the subscription cost.. Valid values are `^[A-Z]{3}$`',
    `last_access_verification_date` DATE COMMENT 'The date when access to the subscription resource was last verified.',
    `last_modified_by` STRING COMMENT 'The username or identifier of the staff member who last modified the subscription record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the subscription record was last updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about the subscription, including special terms, access issues, or renewal considerations.',
    `oer_flag` BOOLEAN COMMENT 'Indicates whether the subscription resource is classified as an Open Educational Resource, freely accessible without cost.',
    `payment_frequency` STRING COMMENT 'The frequency at which subscription payments are made to the vendor.. Valid values are `annual|semi_annual|quarterly|monthly|one_time`',
    `perpetual_access_flag` BOOLEAN COMMENT 'Indicates whether the library retains perpetual access rights to content covered during the subscription period, even after cancellation.',
    `renewal_date` DATE COMMENT 'The date when the subscription is scheduled for renewal or review.',
    `subject_area` STRING COMMENT 'The primary academic subject area or discipline covered by the subscription resource.',
    `subscription_number` STRING COMMENT 'Human-readable business identifier for the subscription, often assigned by the library or vendor.',
    `subscription_status` STRING COMMENT 'Current lifecycle status of the subscription.. Valid values are `active|pending|cancelled|expired|trial`',
    `subscription_type` STRING COMMENT 'The format or delivery method of the subscription resource.. Valid values are `print|online|combined|database|e-book_package`',
    `trial_end_date` DATE COMMENT 'The date when the trial subscription period ends. Null if not a trial subscription.',
    `trial_subscription_flag` BOOLEAN COMMENT 'Indicates whether this is a trial subscription provided by the vendor for evaluation purposes.',
    CONSTRAINT pk_subscription PRIMARY KEY(`subscription_id`)
) COMMENT 'Serial or electronic resource subscription record tracking ongoing access agreements for journals, databases, and e-book packages. Stores subscription title, vendor, coverage start/end dates, subscription type (print, online, combined), annual cost, renewal date, auto-renewal flag, cancellation deadline, and access verification status. Sourced from Alma/Ex Libris serials and ERM modules. Distinct from the license (legal terms) and electronic_resource (technical access) records.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`collection_policy_compliance` (
    `collection_policy_compliance_id` BIGINT COMMENT 'Unique identifier for this collection-policy compliance record. Primary key.',
    `collection_id` BIGINT COMMENT 'Foreign key linking to the library collection being governed by the policy',
    `policy_id` BIGINT COMMENT 'Foreign key linking to the institutional policy that applies to the collection',
    `compliance_notes` STRING COMMENT 'Free-text notes capturing additional context about this collections compliance with this policy, including remediation plans or historical context.',
    `compliance_status` STRING COMMENT 'Current compliance status of this collection with respect to this policy. Values: Compliant, Non-Compliant, Under Review, Exception Approved, Not Applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was first created in the system.',
    `exception_approval_date` DATE COMMENT 'Date when the policy exception was formally approved by the appropriate authority.',
    `exception_expiration_date` DATE COMMENT 'Date when the approved exception expires and the collection must come into full compliance with the policy.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether an exception to this policy has been granted for this collection.',
    `exception_justification` STRING COMMENT 'Narrative explanation of why an exception to this policy was granted for this collection, including approving authority and business rationale.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance record was most recently updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this collection against this policy.',
    `policy_application_date` DATE COMMENT 'Date when this policy was first applied to this collection. Tracks when the compliance relationship began.',
    `review_date` DATE COMMENT 'Date when compliance with this policy was last reviewed for this collection. Used to track compliance audit cycles.',
    CONSTRAINT pk_collection_policy_compliance PRIMARY KEY(`collection_policy_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between library collections and institutional policies. It captures which policies apply to which collections and tracks the compliance status, application dates, and any approved exceptions. Each record links one collection to one policy with attributes that exist only in the context of this compliance relationship.. Existence Justification: In higher education library operations, a single collection must comply with multiple institutional policies (collection development policy, retention policy, donor agreement policy, access restriction policy, FERPA, ADA, etc.), and each institutional policy applies to multiple collections across the library system. The compliance relationship itself carries operational data including application dates, compliance status, review cycles, and approved exceptions that belong to neither the collection nor the policy alone.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`resource_compliance_verification` (
    `resource_compliance_verification_id` BIGINT COMMENT 'Unique identifier for this compliance verification record. Primary key for the association.',
    `electronic_resource_id` BIGINT COMMENT 'Foreign key linking to the electronic resource being assessed for compliance',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to the specific regulatory requirement being verified',
    `compliance_status` STRING COMMENT 'Current compliance status of this electronic resource against this specific regulatory requirement. Explicitly identified in detection reasoning as relationship data.',
    `evidence_document_reference` STRING COMMENT 'Reference to documentation or evidence supporting the compliance verification (e.g., accessibility audit report, vendor VPAT, legal opinion).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review of this resource against this requirement. Explicitly identified in detection reasoning as relationship data.',
    `non_compliance_reason` STRING COMMENT 'Explanation of why this resource does not meet this requirement, if status is non-compliant. Null if compliant.',
    `remediation_deadline` DATE COMMENT 'Target date by which non-compliance issues must be resolved. Null if compliant or not applicable.',
    `responsible_staff` STRING COMMENT 'Name or identifier of the staff member responsible for verifying and maintaining compliance for this resource-requirement pair. Explicitly identified in detection reasoning as relationship data.',
    `verification_date` DATE COMMENT 'Date when compliance with this requirement was last verified for this resource. Corresponds to compliance_verification_date identified in detection reasoning.',
    `verification_method` STRING COMMENT 'Method used to verify compliance (e.g., automated accessibility scan, manual review, vendor certification, legal review). Explicitly identified in detection reasoning as relationship data.',
    `verification_notes` STRING COMMENT 'Detailed notes documenting the verification process, findings, remediation actions, or exceptions for this specific resource-requirement combination.',
    CONSTRAINT pk_resource_compliance_verification PRIMARY KEY(`resource_compliance_verification_id`)
) COMMENT 'This association product represents the compliance verification relationship between electronic resources and regulatory requirements. It captures the ongoing compliance assessment and verification activities for each resource-requirement pair. Each record links one electronic resource to one regulatory requirement with verification status, dates, methods, and responsible staff that exist only in the context of this compliance relationship.. Existence Justification: Electronic resources in higher education must comply with multiple regulatory requirements (ADA accessibility standards, copyright law, FERPA for usage data privacy, state authorization requirements, etc.), and each regulatory requirement applies to multiple electronic resources across the library collection. The compliance office actively manages verification records for each resource-requirement pair, tracking verification status, review cycles, responsible staff, and remediation activities as an operational business process.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`service_desk` (
    `service_desk_id` BIGINT COMMENT 'Primary key for service_desk',
    `building_id` BIGINT COMMENT 'Reference to the library or branch location where this service desk is physically located.',
    `policy_id` BIGINT COMMENT 'Reference to the default circulation loan policy applied to transactions at this desk.',
    `parent_service_desk_id` BIGINT COMMENT 'Self-referencing FK on service_desk (parent_service_desk_id)',
    `accessibility_features` STRING COMMENT 'Description of accessibility accommodations available at this desk (e.g., wheelchair accessible, assistive technology, hearing loop).',
    `checkin_enabled` BOOLEAN COMMENT 'Indicates whether this desk is authorized to perform material checkin/return transactions.',
    `checkout_enabled` BOOLEAN COMMENT 'Indicates whether this desk is authorized to perform material checkout transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service desk record was first created in the system.',
    `service_desk_description` STRING COMMENT 'Detailed description of the service desk purpose, services offered, and patron instructions.',
    `desk_code` STRING COMMENT 'Business identifier code for the service desk used in circulation and patron services systems.',
    `desk_name` STRING COMMENT 'Human-readable name of the service desk (e.g., Main Circulation Desk, Reference Desk, Interlibrary Loan Desk).',
    `desk_type` STRING COMMENT 'Classification of the service desk by primary function within library operations.',
    `effective_end_date` DATE COMMENT 'Date when this service desk configuration expires or was deactivated. Null indicates indefinite operation.',
    `effective_start_date` DATE COMMENT 'Date when this service desk configuration became or will become active.',
    `fine_payment_enabled` BOOLEAN COMMENT 'Indicates whether this desk is authorized to accept patron fine and fee payments.',
    `hold_pickup_enabled` BOOLEAN COMMENT 'Indicates whether this desk serves as a pickup location for patron hold requests.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service desk record was last updated.',
    `location_code` STRING COMMENT 'Physical location code within the library building (e.g., floor, wing, room identifier).',
    `maximum_concurrent_transactions` STRING COMMENT 'Maximum number of simultaneous circulation transactions this desk can process, used for capacity planning.',
    `notes` STRING COMMENT 'Internal staff notes and operational comments about this service desk configuration.',
    `operational_status` STRING COMMENT 'Current operational state of the service desk indicating availability for patron services.',
    `patron_notification_profile` STRING COMMENT 'Configuration profile for automated patron notifications (email, SMS) sent from this desk.',
    `priority_level` STRING COMMENT 'Numeric priority ranking for routing patron requests when multiple desks are available (lower number = higher priority).',
    `public_display_name` STRING COMMENT 'Patron-facing display name used in discovery interfaces, signage, and public communications.',
    `renewal_enabled` BOOLEAN COMMENT 'Indicates whether this desk is authorized to process loan renewal requests.',
    `rfid_enabled` BOOLEAN COMMENT 'Indicates whether this desk is equipped with RFID technology for automated material handling.',
    `security_gate_integrated` BOOLEAN COMMENT 'Indicates whether this desk is integrated with library security gate systems for theft detection.',
    `self_service_enabled` BOOLEAN COMMENT 'Indicates whether this desk location supports patron self-service kiosks or automated checkout stations.',
    `service_hours_profile` STRING COMMENT 'Reference to the operating hours schedule profile applied to this desk (e.g., academic_year_standard, summer_hours, exam_period).',
    `staff_contact_email` STRING COMMENT 'Primary email address for staff inquiries and operational communications related to this service desk.',
    `staff_contact_phone` STRING COMMENT 'Primary phone number for staff and patron inquiries to this service desk.',
    CONSTRAINT pk_service_desk PRIMARY KEY(`service_desk_id`)
) COMMENT 'Master reference table for service_desk. Referenced by checkout_desk_id.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`platform` (
    `platform_id` BIGINT COMMENT 'Primary key for platform',
    `parent_platform_id` BIGINT COMMENT 'Self-referencing FK on platform (parent_platform_id)',
    `access_model` STRING COMMENT 'The business model governing access to resources on this platform.',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the platform meets accessibility standards such as WCAG 2.1 AA or Section 508.',
    `accessibility_statement_url` STRING COMMENT 'URL to the platforms accessibility statement or Voluntary Product Accessibility Template (VPAT).',
    `admin_portal_url` STRING COMMENT 'Web address for the platforms administrative interface used by library staff.',
    `authentication_method` STRING COMMENT 'Primary method used to authenticate users accessing the platform.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether the platform subscription automatically renews at the end of the subscription period.',
    `cancellation_notice_days` STRING COMMENT 'Number of days advance notice required to cancel the subscription before auto-renewal.',
    `content_type` STRING COMMENT 'Primary type of content available on the platform.',
    `counter_compliant` BOOLEAN COMMENT 'Indicates whether the platform provides COUNTER-compliant usage statistics.',
    `counter_release_version` STRING COMMENT 'Version of the COUNTER Code of Practice supported by the platform (e.g., Release 5, Release 4).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the platform record was first created in the library system.',
    `knowledge_base_code` STRING COMMENT 'Identifier linking this platform to the librarys knowledge base for electronic resource management.',
    `marc_prefix` STRING COMMENT 'Prefix code used in MARC records to identify resources from this platform.',
    `mobile_optimized` BOOLEAN COMMENT 'Indicates whether the platform is optimized for mobile device access.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or internal notes about the platform.',
    `openurl_base_url` STRING COMMENT 'Base URL for constructing OpenURL links to resources on this platform.',
    `openurl_compliant` BOOLEAN COMMENT 'Indicates whether the platform supports OpenURL linking for context-sensitive reference linking.',
    `platform_code` STRING COMMENT 'Short alphanumeric code or abbreviation used to identify the platform in library systems and reports.',
    `platform_name` STRING COMMENT 'The official name of the platform (e.g., JSTOR, ProQuest, EBSCO, SpringerLink, IEEE Xplore).',
    `platform_status` STRING COMMENT 'Current operational status of the platform within the library system.',
    `platform_type` STRING COMMENT 'Classification of the platform based on its primary function and content delivery model.',
    `platform_url` STRING COMMENT 'Primary web address for accessing the platform.',
    `proxy_enabled` BOOLEAN COMMENT 'Indicates whether off-campus access to this platform is enabled via proxy server (e.g., EZproxy).',
    `proxy_prefix` STRING COMMENT 'URL prefix added by the proxy server to enable off-campus access to platform resources.',
    `simultaneous_user_limit` STRING COMMENT 'Maximum number of users who can access the platform concurrently, as defined by license terms. Null indicates unlimited access.',
    `subject_coverage` STRING COMMENT 'Broad subject areas or disciplines covered by the platforms content (e.g., STEM, Humanities, Social Sciences, Multidisciplinary).',
    `subscription_end_date` DATE COMMENT 'Date when the current subscription period for the platform ends.',
    `subscription_start_date` DATE COMMENT 'Date when the current subscription period for the platform began.',
    `support_email` STRING COMMENT 'Primary email address for technical support and platform inquiries.',
    `support_phone` STRING COMMENT 'Primary phone number for contacting platform technical support.',
    `sushi_api_key` STRING COMMENT 'API key or token used to authenticate SUSHI requests to the platform.',
    `sushi_requestor_code` STRING COMMENT 'Requestor identifier used for SUSHI authentication, often representing the library or consortium.',
    `sushi_service_url` STRING COMMENT 'API endpoint for automated retrieval of COUNTER usage reports via SUSHI protocol.',
    `trial_end_date` DATE COMMENT 'Date when a trial subscription to the platform ends or ended.',
    `trial_start_date` DATE COMMENT 'Date when a trial subscription to the platform began.',
    `updated_by` STRING COMMENT 'Username or identifier of the library staff member who last updated the platform record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the platform record was last modified in the library system.',
    `vendor_name` STRING COMMENT 'Name of the vendor or publisher that provides the platform.',
    CONSTRAINT pk_platform PRIMARY KEY(`platform_id`)
) COMMENT 'Master reference table for platform. Referenced by platform_id.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`publisher` (
    `publisher_id` BIGINT COMMENT 'Primary key for publisher',
    `parent_publisher_id` BIGINT COMMENT 'Reference to the parent publisher if this publisher is an imprint or subsidiary of a larger publishing house.',
    `acquisition_date` DATE COMMENT 'Date when this publisher was acquired by another entity, if applicable.',
    `address_line_1` STRING COMMENT 'Primary street address line for the publisher headquarters or main office.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `city` STRING COMMENT 'City where the publisher is headquartered or primarily operates.',
    `copyright_policy_url` STRING COMMENT 'URL to the publishers copyright and permissions policy documentation.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the primary country of publication or publisher headquarters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this publisher record was first created in the library system.',
    `defunct_year` STRING COMMENT 'Year the publisher ceased operations, if applicable.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount percentage negotiated with the publisher for institutional purchases.',
    `email_address` STRING COMMENT 'Primary email contact for the publisher organization.',
    `fax_number` STRING COMMENT 'Fax number for the publisher, if applicable.',
    `founding_year` STRING COMMENT 'Year the publisher was established or founded.',
    `imprint` STRING COMMENT 'Imprint or brand name under which the publisher releases materials. An imprint is a trade name under which a publisher or group of publishers publishes a work.',
    `isbn_prefix` STRING COMMENT 'The ISBN prefix assigned to this publisher by the International ISBN Agency. Format: GS1 prefix (978 or 979) followed by registration group and registrant elements.',
    `issn_prefix` STRING COMMENT 'The ISSN prefix or range assigned to this publisher for serial publications.',
    `licensing_terms` STRING COMMENT 'Standard licensing terms or Creative Commons license types typically used by the publisher.',
    `publisher_name` STRING COMMENT 'Full legal or trade name of the publisher organization.',
    `notes` STRING COMMENT 'Free-text notes or comments about the publisher for internal library use.',
    `open_access_policy` STRING COMMENT 'The publishers policy regarding open access publishing and availability of scholarly content.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the publisher (e.g., Net 30, Net 60, prepayment required).',
    `peer_review_policy` STRING COMMENT 'The type of peer review process employed by the publisher for scholarly publications.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the publisher organization.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the publisher address.',
    `predatory_flag` BOOLEAN COMMENT 'Indicator of whether the publisher has been identified as predatory or questionable by recognized watchdog organizations.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this publisher is designated as a preferred vendor for acquisitions.',
    `publisher_code` STRING COMMENT 'Standardized code or abbreviation used to identify the publisher in library systems and cataloging records.',
    `publisher_type` STRING COMMENT 'Classification of the publisher by organizational type and business model.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the publisher is located.',
    `publisher_status` STRING COMMENT 'Current operational status of the publisher in the library system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this publisher record was last modified in the library system.',
    `vendor_account_number` STRING COMMENT 'Account or customer number assigned by the publisher for institutional purchasing and licensing.',
    `website_url` STRING COMMENT 'Official website URL for the publisher.',
    CONSTRAINT pk_publisher PRIMARY KEY(`publisher_id`)
) COMMENT 'Master reference table for publisher. Referenced by publisher_id.';

CREATE OR REPLACE TABLE `education_ecm`.`library`.`library` (
    `library_id` BIGINT COMMENT 'Primary key for library',
    `parent_library_id` BIGINT COMMENT 'Self-referencing FK on library (parent_library_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the library facility meets ADA accessibility standards for patrons with disabilities including wheelchair access, assistive technology, and accessible workstations.',
    `accreditation_status` STRING COMMENT 'Current accreditation status of the library as evaluated by relevant library accreditation bodies or as part of institutional accreditation reviews.',
    `address_line_1` STRING COMMENT 'Primary street address of the library facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number.',
    `annual_circulation_volume` STRING COMMENT 'Total number of items circulated (checked out) in the most recent fiscal year. Key performance metric for library usage and collection relevance.',
    `annual_gate_count` STRING COMMENT 'Total number of patron visits to the library facility in the most recent fiscal year, typically measured by electronic gate counters.',
    `building_name` STRING COMMENT 'Name of the building or facility that houses the library.',
    `campus_id` BIGINT COMMENT 'Reference to the specific campus where this library is physically located. Null for digital-only libraries.',
    `city` STRING COMMENT 'City where the library is located.',
    `collection_size_digital` STRING COMMENT 'Total number of digital items and electronic resources accessible through the library including e-books, e-journals, databases, and digital archives.',
    `collection_size_physical` STRING COMMENT 'Total number of physical items in the library collection including books, journals, media, and other tangible materials. Reported to IPEDS and accreditation bodies.',
    `computer_workstation_count` STRING COMMENT 'Number of public computer workstations available for patron use.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the library location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this library record was first created in the system.',
    `director_name` STRING COMMENT 'Name of the current library director or dean of libraries responsible for overall library operations and strategic direction.',
    `discovery_service_code` STRING COMMENT 'Code identifying the discovery service or search platform used for patron resource discovery. Examples include Primo, Summon, EBSCO Discovery Service, WorldCat Discovery.',
    `email_address` STRING COMMENT 'Primary email address for library inquiries and correspondence.',
    `established_date` DATE COMMENT 'Date when the library was officially established or opened for service.',
    `fax_number` STRING COMMENT 'Fax number for the library, if applicable.',
    `floor_location` STRING COMMENT 'Specific floor or floors within the building where library services and collections are located. May include multiple floors or specific room numbers.',
    `ils_system_code` STRING COMMENT 'Code identifying the integrated library system or library services platform used by this library. Common systems include Alma (Ex Libris), Sierra (Innovative), Koha (open source), FOLIO (open source), Symphony (SirsiDynix), and Voyager (Ex Libris legacy).',
    `institution_id` BIGINT COMMENT 'Reference to the parent educational institution that owns and operates this library.',
    `last_accreditation_review_date` DATE COMMENT 'Date of the most recent accreditation review or assessment of library services and resources.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this library record was most recently updated.',
    `library_code` STRING COMMENT 'Short alphanumeric code used to uniquely identify the library in external systems and catalogs. Often used in interlibrary loan systems and discovery services.',
    `library_name` STRING COMMENT 'Official name of the library as recognized by the institution and external library networks.',
    `library_type` STRING COMMENT 'Classification of the library based on its function and scope within the institution. Main libraries serve as central hubs, branch libraries serve specific campuses, departmental libraries support specific academic departments, special collections house rare materials, digital libraries provide electronic resources, and archives preserve institutional records.',
    `oclc_symbol` STRING COMMENT 'Unique OCLC institution symbol used for interlibrary loan, cataloging, and resource sharing through WorldCat and other OCLC services.',
    `operating_hours_weekly` DECIMAL(18,2) COMMENT 'Total number of hours the library is open to patrons during a typical week during the academic term. Used for service level reporting and staffing planning.',
    `operational_status` STRING COMMENT 'Current operational state of the library. Active libraries are fully operational, inactive libraries are permanently closed, temporarily closed libraries are closed for a defined period, under renovation libraries are undergoing facility improvements, and planned libraries are in pre-opening phase.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the library.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the library address.',
    `seating_capacity` STRING COMMENT 'Total number of patron seats available in the library including study tables, carrels, lounge seating, and computer workstations.',
    `staff_count_fte` DECIMAL(18,2) COMMENT 'Total number of library staff measured in full-time equivalents, including librarians, support staff, and student workers. Reported to IPEDS.',
    `state_province` STRING COMMENT 'State or province where the library is located. Use standard two-letter abbreviations for US states.',
    `study_room_count` STRING COMMENT 'Number of individual or group study rooms available for patron reservation and use.',
    `supports_interlibrary_loan` BOOLEAN COMMENT 'Indicates whether this library participates in interlibrary loan services, allowing patrons to borrow materials from other libraries and lending materials to external institutions.',
    `supports_oer_tracking` BOOLEAN COMMENT 'Indicates whether this library tracks and promotes open educational resources as part of its collection and services to reduce textbook costs for students.',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Total physical space of the library facility measured in square feet. Used for space planning, capacity analysis, and reporting to accreditation bodies.',
    `website_url` STRING COMMENT 'URL of the librarys public website providing information about services, hours, and resources.',
    CONSTRAINT pk_library PRIMARY KEY(`library_id`)
) COMMENT 'Master reference table for library. Referenced by library_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`library`.`holding` ADD CONSTRAINT `fk_library_holding_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`library`.`holding` ADD CONSTRAINT `fk_library_holding_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);
ALTER TABLE `education_ecm`.`library`.`item` ADD CONSTRAINT `fk_library_item_holding_id` FOREIGN KEY (`holding_id`) REFERENCES `education_ecm`.`library`.`holding`(`holding_id`);
ALTER TABLE `education_ecm`.`library`.`loan` ADD CONSTRAINT `fk_library_loan_service_desk_id` FOREIGN KEY (`service_desk_id`) REFERENCES `education_ecm`.`library`.`service_desk`(`service_desk_id`);
ALTER TABLE `education_ecm`.`library`.`loan` ADD CONSTRAINT `fk_library_loan_item_id` FOREIGN KEY (`item_id`) REFERENCES `education_ecm`.`library`.`item`(`item_id`);
ALTER TABLE `education_ecm`.`library`.`loan` ADD CONSTRAINT `fk_library_loan_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`hold_request` ADD CONSTRAINT `fk_library_hold_request_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`library`.`hold_request` ADD CONSTRAINT `fk_library_hold_request_item_id` FOREIGN KEY (`item_id`) REFERENCES `education_ecm`.`library`.`item`(`item_id`);
ALTER TABLE `education_ecm`.`library`.`hold_request` ADD CONSTRAINT `fk_library_hold_request_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`ill_request` ADD CONSTRAINT `fk_library_ill_request_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`library`.`ill_request` ADD CONSTRAINT `fk_library_ill_request_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_item_id` FOREIGN KEY (`item_id`) REFERENCES `education_ecm`.`library`.`item`(`item_id`);
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `education_ecm`.`library`.`loan`(`loan_id`);
ALTER TABLE `education_ecm`.`library`.`fine` ADD CONSTRAINT `fk_library_fine_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_bib_record_id` FOREIGN KEY (`bib_record_id`) REFERENCES `education_ecm`.`library`.`bib_record`(`bib_record_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_library_fund_id` FOREIGN KEY (`library_fund_id`) REFERENCES `education_ecm`.`library`.`library_fund`(`library_fund_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_library_vendor_id` FOREIGN KEY (`library_vendor_id`) REFERENCES `education_ecm`.`library`.`library_vendor`(`library_vendor_id`);
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ADD CONSTRAINT `fk_library_acquisition_order_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`library_fund` ADD CONSTRAINT `fk_library_library_fund_parent_fund_library_fund_id` FOREIGN KEY (`parent_fund_library_fund_id`) REFERENCES `education_ecm`.`library`.`library_fund`(`library_fund_id`);
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ADD CONSTRAINT `fk_library_electronic_resource_license_id` FOREIGN KEY (`license_id`) REFERENCES `education_ecm`.`library`.`license`(`license_id`);
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_electronic_resource_id` FOREIGN KEY (`electronic_resource_id`) REFERENCES `education_ecm`.`library`.`electronic_resource`(`electronic_resource_id`);
ALTER TABLE `education_ecm`.`library`.`course_reserve` ADD CONSTRAINT `fk_library_course_reserve_item_id` FOREIGN KEY (`item_id`) REFERENCES `education_ecm`.`library`.`item`(`item_id`);
ALTER TABLE `education_ecm`.`library`.`oer_resource` ADD CONSTRAINT `fk_library_oer_resource_digital_object_id` FOREIGN KEY (`digital_object_id`) REFERENCES `education_ecm`.`library`.`digital_object`(`digital_object_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);
ALTER TABLE `education_ecm`.`library`.`digital_object` ADD CONSTRAINT `fk_library_digital_object_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`collection` ADD CONSTRAINT `fk_library_collection_library_fund_id` FOREIGN KEY (`library_fund_id`) REFERENCES `education_ecm`.`library`.`library_fund`(`library_fund_id`);
ALTER TABLE `education_ecm`.`library`.`research_support_request` ADD CONSTRAINT `fk_library_research_support_request_patron_id` FOREIGN KEY (`patron_id`) REFERENCES `education_ecm`.`library`.`patron`(`patron_id`);
ALTER TABLE `education_ecm`.`library`.`usage_stat` ADD CONSTRAINT `fk_library_usage_stat_electronic_resource_id` FOREIGN KEY (`electronic_resource_id`) REFERENCES `education_ecm`.`library`.`electronic_resource`(`electronic_resource_id`);
ALTER TABLE `education_ecm`.`library`.`usage_stat` ADD CONSTRAINT `fk_library_usage_stat_platform_id` FOREIGN KEY (`platform_id`) REFERENCES `education_ecm`.`library`.`platform`(`platform_id`);
ALTER TABLE `education_ecm`.`library`.`usage_stat` ADD CONSTRAINT `fk_library_usage_stat_publisher_id` FOREIGN KEY (`publisher_id`) REFERENCES `education_ecm`.`library`.`publisher`(`publisher_id`);
ALTER TABLE `education_ecm`.`library`.`subscription` ADD CONSTRAINT `fk_library_subscription_electronic_resource_id` FOREIGN KEY (`electronic_resource_id`) REFERENCES `education_ecm`.`library`.`electronic_resource`(`electronic_resource_id`);
ALTER TABLE `education_ecm`.`library`.`subscription` ADD CONSTRAINT `fk_library_subscription_library_fund_id` FOREIGN KEY (`library_fund_id`) REFERENCES `education_ecm`.`library`.`library_fund`(`library_fund_id`);
ALTER TABLE `education_ecm`.`library`.`subscription` ADD CONSTRAINT `fk_library_subscription_library_vendor_id` FOREIGN KEY (`library_vendor_id`) REFERENCES `education_ecm`.`library`.`library_vendor`(`library_vendor_id`);
ALTER TABLE `education_ecm`.`library`.`subscription` ADD CONSTRAINT `fk_library_subscription_license_id` FOREIGN KEY (`license_id`) REFERENCES `education_ecm`.`library`.`license`(`license_id`);
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ADD CONSTRAINT `fk_library_collection_policy_compliance_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `education_ecm`.`library`.`collection`(`collection_id`);
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ADD CONSTRAINT `fk_library_resource_compliance_verification_electronic_resource_id` FOREIGN KEY (`electronic_resource_id`) REFERENCES `education_ecm`.`library`.`electronic_resource`(`electronic_resource_id`);
ALTER TABLE `education_ecm`.`library`.`service_desk` ADD CONSTRAINT `fk_library_service_desk_parent_service_desk_id` FOREIGN KEY (`parent_service_desk_id`) REFERENCES `education_ecm`.`library`.`service_desk`(`service_desk_id`);
ALTER TABLE `education_ecm`.`library`.`platform` ADD CONSTRAINT `fk_library_platform_parent_platform_id` FOREIGN KEY (`parent_platform_id`) REFERENCES `education_ecm`.`library`.`platform`(`platform_id`);
ALTER TABLE `education_ecm`.`library`.`publisher` ADD CONSTRAINT `fk_library_publisher_parent_publisher_id` FOREIGN KEY (`parent_publisher_id`) REFERENCES `education_ecm`.`library`.`publisher`(`publisher_id`);
ALTER TABLE `education_ecm`.`library`.`library` ADD CONSTRAINT `fk_library_library_parent_library_id` FOREIGN KEY (`parent_library_id`) REFERENCES `education_ecm`.`library`.`library`(`library_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`library` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `education_ecm`.`library` SET TAGS ('dbx_domain' = 'library');
ALTER TABLE `education_ecm`.`library`.`bib_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`bib_record` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bibliographic Record Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `author` SET TAGS ('dbx_business_glossary_term' = 'Author or Creator');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `bib_record_description` SET TAGS ('dbx_business_glossary_term' = 'Physical Description');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `catalog_status` SET TAGS ('dbx_business_glossary_term' = 'Catalog Status');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `catalog_status` SET TAGS ('dbx_value_regex' = 'active|suppressed|deleted|in_process|withdrawn');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `cataloging_level` SET TAGS ('dbx_business_glossary_term' = 'Cataloging Level');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `circulation_count` SET TAGS ('dbx_business_glossary_term' = 'Circulation Count');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `copyright_year` SET TAGS ('dbx_business_glossary_term' = 'Copyright Year');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Date');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `dewey_call_number` SET TAGS ('dbx_business_glossary_term' = 'Dewey Decimal Classification (DDC) Number');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `edition` SET TAGS ('dbx_business_glossary_term' = 'Edition Statement');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `encoding_level` SET TAGS ('dbx_business_glossary_term' = 'Encoding Level');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Format Type');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'monograph|serial|electronic|audiovisual|manuscript|map');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `holdings_count` SET TAGS ('dbx_business_glossary_term' = 'Holdings Count');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `isbn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Book Number (ISBN)');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `issn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Serial Number (ISSN)');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `last_circulation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Circulation Date');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `lc_call_number` SET TAGS ('dbx_business_glossary_term' = 'Library of Congress (LC) Call Number');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `lccn` SET TAGS ('dbx_business_glossary_term' = 'Library of Congress Control Number (LCCN)');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `marc_record` SET TAGS ('dbx_business_glossary_term' = 'MARC (Machine-Readable Cataloging) Record');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material or Media Type');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `mms_code` SET TAGS ('dbx_business_glossary_term' = 'MARC Management System (MMS) Identifier');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `oclc_number` SET TAGS ('dbx_business_glossary_term' = 'Online Computer Library Center (OCLC) Control Number');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `peer_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewed Flag');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `publication_place` SET TAGS ('dbx_business_glossary_term' = 'Place of Publication');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `publication_year` SET TAGS ('dbx_business_glossary_term' = 'Publication Year');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `publisher` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `series_statement` SET TAGS ('dbx_business_glossary_term' = 'Series Statement');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `subject_headings` SET TAGS ('dbx_business_glossary_term' = 'Subject Headings');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `suppressed_from_discovery` SET TAGS ('dbx_business_glossary_term' = 'Suppressed From Discovery Flag');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title Statement');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`bib_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `education_ecm`.`library`.`holding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`holding` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `holding_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bibliographic Record Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `access_policy` SET TAGS ('dbx_business_glossary_term' = 'Access Policy');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `access_policy` SET TAGS ('dbx_value_regex' = 'open|restricted|staff_only|special_permission|course_reserves');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'purchase|gift|exchange|deposit|license|subscription');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Call Number');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `call_number_type` SET TAGS ('dbx_business_glossary_term' = 'Call Number Type');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `call_number_type` SET TAGS ('dbx_value_regex' = 'lc|dewey|sudoc|local|other');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `copy_statement` SET TAGS ('dbx_business_glossary_term' = 'Copy Statement');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `copyright_status` SET TAGS ('dbx_business_glossary_term' = 'Copyright Status');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `copyright_status` SET TAGS ('dbx_value_regex' = 'in_copyright|public_domain|unknown|licensed');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `digitization_status` SET TAGS ('dbx_business_glossary_term' = 'Digitization Status');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `digitization_status` SET TAGS ('dbx_value_regex' = 'not_digitized|in_queue|in_progress|completed|not_applicable');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `electronic_access_url` SET TAGS ('dbx_business_glossary_term' = 'Electronic Access Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `enumeration_chronology` SET TAGS ('dbx_business_glossary_term' = 'Enumeration and Chronology');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `holding_type` SET TAGS ('dbx_business_glossary_term' = 'Holding Type');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `holding_type` SET TAGS ('dbx_value_regex' = 'physical|electronic|digital|microform|serial|monograph');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `holdings_status` SET TAGS ('dbx_business_glossary_term' = 'Holdings Status');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `holdings_status` SET TAGS ('dbx_value_regex' = 'active|inactive|withdrawn|lost|missing|in_process');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `internal_note` SET TAGS ('dbx_business_glossary_term' = 'Internal Note');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `internal_note` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `last_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Date');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `library_code` SET TAGS ('dbx_business_glossary_term' = 'Library Code');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `library_name` SET TAGS ('dbx_business_glossary_term' = 'Library Name');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `license_code` SET TAGS ('dbx_business_glossary_term' = 'License Code');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `mms_code` SET TAGS ('dbx_business_glossary_term' = 'Metadata Management System (MMS) Identifier');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `permanent_location` SET TAGS ('dbx_business_glossary_term' = 'Permanent Location');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `preservation_priority` SET TAGS ('dbx_business_glossary_term' = 'Preservation Priority');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `preservation_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Amount');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `proxy_enabled` SET TAGS ('dbx_business_glossary_term' = 'Proxy Enabled Flag');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `public_note` SET TAGS ('dbx_business_glossary_term' = 'Public Note');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `receiving_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `receiving_status` SET TAGS ('dbx_value_regex' = 'complete|in_progress|ceased|cancelled|on_order');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `shelving_location` SET TAGS ('dbx_business_glossary_term' = 'Shelving Location');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `statistical_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Code');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `suppressed_from_discovery` SET TAGS ('dbx_business_glossary_term' = 'Suppressed from Discovery Flag');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `temporary_location` SET TAGS ('dbx_business_glossary_term' = 'Temporary Location');
ALTER TABLE `education_ecm`.`library`.`holding` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `education_ecm`.`library`.`item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`item` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `holding_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Identifier');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'purchase|gift|exchange|deposit|transfer');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Item Barcode');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Call Number');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `call_number_type` SET TAGS ('dbx_business_glossary_term' = 'Call Number Type');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `call_number_type` SET TAGS ('dbx_value_regex' = 'lc|dewey|sudoc|local|other');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `cataloging_date` SET TAGS ('dbx_business_glossary_term' = 'Cataloging Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `chronology` SET TAGS ('dbx_business_glossary_term' = 'Chronology');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `condition_notes` SET TAGS ('dbx_business_glossary_term' = 'Condition Notes');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `copy_number` SET TAGS ('dbx_business_glossary_term' = 'Copy Number');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `enumeration` SET TAGS ('dbx_business_glossary_term' = 'Enumeration');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `internal_note` SET TAGS ('dbx_business_glossary_term' = 'Internal Note');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `internal_note` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'verified|not_found|misshelved|damaged|other');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `is_fragile` SET TAGS ('dbx_business_glossary_term' = 'Is Fragile');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `is_magnetic_media` SET TAGS ('dbx_business_glossary_term' = 'Is Magnetic Media');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `is_suppressed` SET TAGS ('dbx_business_glossary_term' = 'Is Suppressed');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Item Status');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `last_loan_date` SET TAGS ('dbx_business_glossary_term' = 'Last Loan Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `last_return_date` SET TAGS ('dbx_business_glossary_term' = 'Last Return Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `loan_count` SET TAGS ('dbx_business_glossary_term' = 'Loan Count');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `physical_condition` SET TAGS ('dbx_business_glossary_term' = 'Physical Condition');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `physical_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|damaged|needs_repair');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `policy` SET TAGS ('dbx_business_glossary_term' = 'Item Policy');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `policy` SET TAGS ('dbx_value_regex' = 'general_circulation|reserve|reference|non_circulating|special_collections|restricted');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `provenance_notes` SET TAGS ('dbx_business_glossary_term' = 'Provenance Notes');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `public_note` SET TAGS ('dbx_business_glossary_term' = 'Public Note');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Receiving Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `statistical_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Code');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_value_regex' = 'damaged|lost|obsolete|duplicate|low_use|transferred');
ALTER TABLE `education_ecm`.`library`.`item` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `education_ecm`.`library`.`patron` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`patron` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `identity_account_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Needs');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `accessibility_needs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_business_glossary_term' = 'Alternate Email Address');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `alternate_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Patron Barcode');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `blocked_status` SET TAGS ('dbx_business_glossary_term' = 'Blocked Status');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `borrower_category` SET TAGS ('dbx_business_glossary_term' = 'Borrower Category');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `borrower_category` SET TAGS ('dbx_value_regex' = 'standard|extended|restricted|temporary|alumni|reciprocal');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `campus_location` SET TAGS ('dbx_business_glossary_term' = 'Campus Location');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `directory_opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Opt-Out Flag');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Patron Email Address');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Patron Expiration Date');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `external_system_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'External System Synchronization Timestamp');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `ferpa_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'FERPA (Family Educational Rights and Privacy Act) Consent Flag');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Patron Full Name');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `interlibrary_loan_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Interlibrary Loan (ILL) Eligible Flag');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Patron Notes');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `patron_type` SET TAGS ('dbx_business_glossary_term' = 'Patron Type');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `patron_type` SET TAGS ('dbx_value_regex' = 'undergraduate_student|graduate_student|faculty|staff|community_borrower|visiting_scholar');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Patron Phone Number');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Patron Preferred Name');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `preferred_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Notification Channel');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `preferred_notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `primary_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Primary Institutional Affiliation');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `proxy_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Proxy Authorization Flag');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Patron Registration Date');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `research_support_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research Support Eligible Flag');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `special_collections_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Collections Access Flag');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `statistical_category` SET TAGS ('dbx_business_glossary_term' = 'Statistical Category');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `total_charges_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Outstanding');
ALTER TABLE `education_ecm`.`library`.`patron` ALTER COLUMN `total_fines_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Total Fines Outstanding');
ALTER TABLE `education_ecm`.`library`.`loan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`loan` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `service_desk_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Desk Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Operator Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_return_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Return Operator Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_return_operator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_return_operator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Policy Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Item Barcode');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Call Number');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `checkout_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Checkout Date and Time');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `claimed_returned_date` SET TAGS ('dbx_business_glossary_term' = 'Claimed Returned Date');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_amount_accrued` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount Accrued');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount Paid');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_amount_waived` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount Waived');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_collection_status` SET TAGS ('dbx_business_glossary_term' = 'Fine Collection Status');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_collection_status` SET TAGS ('dbx_value_regex' = 'open|paid|waived|sent_to_collections|written_off');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fine Payment Date');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_type` SET TAGS ('dbx_business_glossary_term' = 'Fine Type');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_type` SET TAGS ('dbx_value_regex' = 'overdue|lost|damaged|service_charge|replacement|processing');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `fine_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fine Waiver Reason');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `is_claimed_returned` SET TAGS ('dbx_business_glossary_term' = 'Claimed Returned Indicator');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `is_lost` SET TAGS ('dbx_business_glossary_term' = 'Lost Item Indicator');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Overdue Indicator');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Transaction Number');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Status');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Type');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `loan_type` SET TAGS ('dbx_value_regex' = 'regular|reserve|interlibrary|equipment|digital');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Item Location Code');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `lost_date` SET TAGS ('dbx_business_glossary_term' = 'Lost Item Date');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Loan Notes');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Overdue Days Count');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `patron_group` SET TAGS ('dbx_business_glossary_term' = 'Patron Group');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `recall_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Due Date');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `recall_requested` SET TAGS ('dbx_business_glossary_term' = 'Recall Requested Indicator');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `return_desk_code` SET TAGS ('dbx_business_glossary_term' = 'Return Desk Identifier');
ALTER TABLE `education_ecm`.`library`.`loan` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Date and Time');
ALTER TABLE `education_ecm`.`library`.`hold_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`hold_request` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `hold_request_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Request ID');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title ID');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location ID');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron ID');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Item Barcode');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `call_number` SET TAGS ('dbx_business_glossary_term' = 'Call Number');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'patron_request|item_unavailable|expired|duplicate|other');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `estimated_availability_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Availability Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `hold_shelf_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Shelf Expiration Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `isbn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Book Number (ISBN)');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `issn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Serial Number (ISSN)');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'book|journal|dvd|equipment|special_collections|electronic');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|mail');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `owning_library_code` SET TAGS ('dbx_business_glossary_term' = 'Owning Library Code');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `patron_comments` SET TAGS ('dbx_business_glossary_term' = 'Patron Comments');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `patron_group` SET TAGS ('dbx_business_glossary_term' = 'Patron Group');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `patron_group` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|faculty|staff|alumni|community');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `pickup_location_code` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location Code');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|faculty|reserve');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Queue Position');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'opac|mobile_app|staff_interface|api|discovery_service');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|ready_for_pickup|expired|cancelled|fulfilled');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'hold|recall|booking|digitization');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `staff_notes` SET TAGS ('dbx_business_glossary_term' = 'Staff Notes');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `transit_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Transit Arrival Date');
ALTER TABLE `education_ecm`.`library`.`hold_request` ALTER COLUMN `transit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Transit Start Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`ill_request` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `ill_request_id` SET TAGS ('dbx_business_glossary_term' = 'Interlibrary Loan (ILL) Request ID');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron ID');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `article_title` SET TAGS ('dbx_business_glossary_term' = 'Article Title');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `borrowing_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Borrowing Institution Code');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'patron_request|item_unavailable|duplicate_request|no_longer_needed|cost_exceeded|copyright_restriction');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `copyright_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Copyright Compliance Flag');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `issue` SET TAGS ('dbx_business_glossary_term' = 'Issue');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `journal_title` SET TAGS ('dbx_business_glossary_term' = 'Journal Title');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `lending_institution_code` SET TAGS ('dbx_business_glossary_term' = 'Lending Institution Code');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `lending_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Lending Institution Name');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `needed_by_date` SET TAGS ('dbx_business_glossary_term' = 'Needed By Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `oclc_ill_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Online Computer Library Center (OCLC) Interlibrary Loan (ILL) Transaction Number');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `pages` SET TAGS ('dbx_business_glossary_term' = 'Pages');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `patron_charged_amount` SET TAGS ('dbx_business_glossary_term' = 'Patron Charged Amount');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `pickup_location` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'borrowing|lending|copy_request|loan_request');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `returned_date` SET TAGS ('dbx_business_glossary_term' = 'Returned Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `shipped_date` SET TAGS ('dbx_business_glossary_term' = 'Shipped Date');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `staff_notes` SET TAGS ('dbx_business_glossary_term' = 'Staff Notes');
ALTER TABLE `education_ecm`.`library`.`ill_request` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `education_ecm`.`library`.`fine` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`fine` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `fine_id` SET TAGS ('dbx_business_glossary_term' = 'Fine ID');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Operator ID');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `loan_id` SET TAGS ('dbx_business_glossary_term' = 'Loan ID');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron ID');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `amount_waived` SET TAGS ('dbx_business_glossary_term' = 'Amount Waived');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `balance_due` SET TAGS ('dbx_business_glossary_term' = 'Balance Due');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `billing_export_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Export Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `billing_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Integration Flag');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `collections_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `collections_status` SET TAGS ('dbx_business_glossary_term' = 'Collections Status');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `collections_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent_to_collections|in_collections|resolved|recalled');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `daily_fine_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Fine Rate');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `dispute_resolution` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `fine_number` SET TAGS ('dbx_business_glossary_term' = 'Fine Number');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `fine_status` SET TAGS ('dbx_business_glossary_term' = 'Fine Status');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `fine_status` SET TAGS ('dbx_value_regex' = 'open|paid|waived|partially_paid|in_collections|cancelled');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `fine_type` SET TAGS ('dbx_business_glossary_term' = 'Fine Type');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `fine_type` SET TAGS ('dbx_value_regex' = 'overdue|lost_item|damaged_item|replacement_fee|processing_fee|service_charge');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `library_location` SET TAGS ('dbx_business_glossary_term' = 'Library Location');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `maximum_fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fine Amount');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Amount');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `overdue_days` SET TAGS ('dbx_business_glossary_term' = 'Overdue Days');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `patron_group` SET TAGS ('dbx_business_glossary_term' = 'Patron Group');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `education_ecm`.`library`.`fine` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` SET TAGS ('dbx_subdomain' = 'resource_acquisition');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `acquisition_order_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Order Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `bib_record_id` SET TAGS ('dbx_business_glossary_term' = 'Bib Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Selector Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `library_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Code Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `library_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|cancelled');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'book|serial|electronic_resource|audiovisual|manuscript|map');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|approved|sent|received|cancelled|closed');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'firm|approval|standing_order|subscription|gift|exchange');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_business_glossary_term' = 'Receiving Status');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `receiving_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_received|fully_received|backordered');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `rush_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Rush Order Flag');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `education_ecm`.`library`.`acquisition_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `education_ecm`.`library`.`library_vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`library_vendor` SET TAGS ('dbx_subdomain' = 'resource_acquisition');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `library_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Library Vendor Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Library Account Number');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 1');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 2');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `approval_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Plan Flag');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `claiming_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Claiming Interval Days');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `edi_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Vendor Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `firm_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Firm Order Flag');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `return_policy` SET TAGS ('dbx_business_glossary_term' = 'Return Policy');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `standing_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Flag');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Vendor State or Province');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `subscription_flag` SET TAGS ('dbx_business_glossary_term' = 'Subscription Flag');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'book_jobber|subscription_agent|publisher|database_provider|serials_vendor|media_vendor');
ALTER TABLE `education_ecm`.`library`.`library_vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`library_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`library_fund` SET TAGS ('dbx_subdomain' = 'resource_acquisition');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `library_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Library Fund ID');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor ID');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `parent_fund_library_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fund ID');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `primary_library_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Owner ID');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `primary_library_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `primary_library_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `encumbered_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbered Amount');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Fund End Date');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `expended_amount` SET TAGS ('dbx_business_glossary_term' = 'Expended Amount');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_source` SET TAGS ('dbx_business_glossary_term' = 'Fund Source');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|frozen|pending');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'allocated|encumbered|expended|restricted|unrestricted|endowment');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fund Notes');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `oer_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Eligible Flag');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `rollover_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Flag');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Start Date');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Subject Area');
ALTER TABLE `education_ecm`.`library`.`library_fund` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `electronic_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource ID');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `ada_accommodation_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Accommodation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `access_model` SET TAGS ('dbx_business_glossary_term' = 'Access Model');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `access_model` SET TAGS ('dbx_value_regex' = 'unlimited|simultaneous_users|single_user|dda|pda');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|trial|pending_activation|cancelled');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Subscription Cost');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `cancellation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Deadline');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `counter_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Counting Online Usage of Networked Electronic Resources (COUNTER) Compliant Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `course_reserves_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Course Reserves Permitted Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `interlibrary_loan_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Interlibrary Loan (ILL) Permitted Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `knowledge_base_code` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Base ID');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `last_usage_harvest_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Harvest Timestamp');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `marc_record_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Machine-Readable Cataloging (MARC) Record Available Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `perpetual_access_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Perpetual Access Rights Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `proxy_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Proxy Enabled Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `public_notes` SET TAGS ('dbx_business_glossary_term' = 'Public Notes');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource Code');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource Name');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource Type');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'database|e-journal_package|e-book_collection|streaming_media|reference_tool|data_repository');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `simultaneous_user_limit` SET TAGS ('dbx_business_glossary_term' = 'Simultaneous User Limit');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Subject Area');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'online_only|print_plus_online|print_only|perpetual_access|open_access');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `sushi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Standardized Usage Statistics Harvesting Initiative (SUSHI) Enabled Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `sushi_service_url` SET TAGS ('dbx_business_glossary_term' = 'Standardized Usage Statistics Harvesting Initiative (SUSHI) Service Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `trial_flag` SET TAGS ('dbx_business_glossary_term' = 'Trial Flag');
ALTER TABLE `education_ecm`.`library`.`electronic_resource` ALTER COLUMN `trial_start_date` SET TAGS ('dbx_business_glossary_term' = 'Trial Start Date');
ALTER TABLE `education_ecm`.`library`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`license` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `archival_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Archival Rights Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `authorized_users_definition` SET TAGS ('dbx_business_glossary_term' = 'Authorized Users Definition');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Renewal Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `concurrent_user_limit` SET TAGS ('dbx_business_glossary_term' = 'Concurrent User Limit');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `course_reserve_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Course Reserve Allowed Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'License Document Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `ill_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Interlibrary Loan (ILL) Allowed Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `ill_electronic_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Interlibrary Loan (ILL) Electronic Delivery Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `indemnification_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Clause Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_code` SET TAGS ('dbx_business_glossary_term' = 'License Code');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_name` SET TAGS ('dbx_business_glossary_term' = 'License Name');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|suspended|under_review');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'standard|negotiated|open_access|trial|consortium|custom');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Licensor Contact Email Address');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `licensor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `licensor_name` SET TAGS ('dbx_business_glossary_term' = 'Licensor Name');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `perpetual_access_coverage` SET TAGS ('dbx_business_glossary_term' = 'Perpetual Access Coverage');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `perpetual_access_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Perpetual Access Rights Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `remote_access_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Access Allowed Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Date');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'License Review Date');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `scholarly_sharing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Scholarly Sharing Allowed Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `text_data_mining_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Text and Data Mining (TDM) Allowed Flag');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `usage_statistics_format` SET TAGS ('dbx_business_glossary_term' = 'Usage Statistics Format');
ALTER TABLE `education_ecm`.`library`.`license` ALTER COLUMN `usage_statistics_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Usage Statistics Provided Flag');
ALTER TABLE `education_ecm`.`library`.`course_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`course_reserve` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `course_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Course Reserve ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Copyright Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `electronic_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Staff ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Library Item ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Course ID');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `access_url` SET TAGS ('dbx_business_glossary_term' = 'Access Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `alternative_format_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Format Available Flag');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `citation_text` SET TAGS ('dbx_business_glossary_term' = 'Citation Text');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `copyright_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Copyright Clearance Date');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `copyright_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Copyright Clearance Status');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `copyright_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|not_required|denied|fair_use');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `copyright_notes` SET TAGS ('dbx_business_glossary_term' = 'Copyright Notes');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `last_usage_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `lms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Learning Management System (LMS) Integration Flag');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `loan_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Loan Period Hours');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Notes');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Date');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|cancelled|processing');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'physical|electronic|digitized|streaming_media|citation_only');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`library`.`course_reserve` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `education_ecm`.`library`.`oer_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`oer_resource` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `oer_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Library Open Educational Resource (OER) Resource ID');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Author Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `coa_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `accreditation_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Accreditation Standard Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `digital_object_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `lms_course_shell_id` SET TAGS ('dbx_business_glossary_term' = 'Lms Course Shell Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Course ID');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Adopting Faculty Member ID');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `academic_term` SET TAGS ('dbx_business_glossary_term' = 'Academic Term');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `accessibility_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `accessibility_notes` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Notes');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Adoption Date');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `adoption_status` SET TAGS ('dbx_business_glossary_term' = 'Adoption Status');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `adoption_status` SET TAGS ('dbx_value_regex' = 'Adopted|Under Review|Recommended|Not Adopted|Retired');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `alternate_url` SET TAGS ('dbx_business_glossary_term' = 'Alternate Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `alternate_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `author_creator` SET TAGS ('dbx_business_glossary_term' = 'Author or Creator Name');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^d{2}.d{4}$');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `cip_title` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Title');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `edition` SET TAGS ('dbx_business_glossary_term' = 'Edition');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `estimated_cost_savings_per_student` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Savings Per Student');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `estimated_student_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Student Count');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `institutional_repository_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Repository Flag');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `keywords` SET TAGS ('dbx_business_glossary_term' = 'Keywords');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'Creative Commons (CC) License Type');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'CC-BY|CC-BY-SA|CC-BY-NC|CC-BY-NC-SA|CC0|Public Domain');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `license_url` SET TAGS ('dbx_business_glossary_term' = 'License Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `license_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `license_version` SET TAGS ('dbx_business_glossary_term' = 'License Version');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `publisher` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `resource_description` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Description');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `resource_format` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Format');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `resource_subtitle` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Subtitle');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `resource_title` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Title');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `resource_url` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `resource_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'Not Reviewed|Under Review|Reviewed|Approved|Rejected');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Subject Area');
ALTER TABLE `education_ecm`.`library`.`oer_resource` ALTER COLUMN `total_estimated_cost_savings` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost Savings');
ALTER TABLE `education_ecm`.`library`.`digital_object` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`digital_object` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `digital_object_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Object ID');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Author Profile Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Creator Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `instruction_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Creator ID');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Object Abstract');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `academic_department` SET TAGS ('dbx_business_glossary_term' = 'Academic Department');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `access_rights` SET TAGS ('dbx_business_glossary_term' = 'Access Rights');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `access_rights` SET TAGS ('dbx_value_regex' = 'open_access|campus_only|restricted|embargoed|dark_archive');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `contributor_names` SET TAGS ('dbx_business_glossary_term' = 'Contributor Names');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `degree_level` SET TAGS ('dbx_business_glossary_term' = 'Degree Level');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `degree_level` SET TAGS ('dbx_value_regex' = 'bachelors|masters|doctoral|post_doctoral');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `degree_name` SET TAGS ('dbx_business_glossary_term' = 'Degree Name');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `doi` SET TAGS ('dbx_value_regex' = '^10.d{4,9}/[-._;()/:A-Za-z0-9]+$');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `download_count` SET TAGS ('dbx_business_glossary_term' = 'Download Count');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `embargo_end_date` SET TAGS ('dbx_business_glossary_term' = 'Embargo End Date');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `estimated_student_savings_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Student Cost Savings in United States Dollars (USD)');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `graduation_year` SET TAGS ('dbx_business_glossary_term' = 'Graduation Year');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `handle` SET TAGS ('dbx_business_glossary_term' = 'Handle Identifier');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `last_preservation_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preservation Check Date');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'cc_by|cc_by_sa|cc_by_nc|cc_by_nd|cc0|all_rights_reserved');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `object_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Type');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `object_type` SET TAGS ('dbx_value_regex' = 'thesis|dissertation|faculty_publication|digitized_collection|oer|dataset');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `oer_adoption_status` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Adoption Status');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `oer_adoption_status` SET TAGS ('dbx_value_regex' = 'not_adopted|pilot|adopted|retired');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `open_access_mandate_compliance` SET TAGS ('dbx_business_glossary_term' = 'Open Access Mandate Compliance Flag');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `peer_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewed Flag');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `persistent_identifier` SET TAGS ('dbx_business_glossary_term' = 'Persistent Identifier');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `preservation_status` SET TAGS ('dbx_business_glossary_term' = 'Preservation Status');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `preservation_status` SET TAGS ('dbx_value_regex' = 'active|archived|at_risk|obsolete');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `publisher` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `subject_keywords` SET TAGS ('dbx_business_glossary_term' = 'Subject Keywords');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `subtitle` SET TAGS ('dbx_business_glossary_term' = 'Object Subtitle');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Object Title');
ALTER TABLE `education_ecm`.`library`.`digital_object` ALTER COLUMN `view_count` SET TAGS ('dbx_business_glossary_term' = 'View Count');
ALTER TABLE `education_ecm`.`library`.`collection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`collection` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Subject Librarian ID');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `library_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Library Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `sport_id` SET TAGS ('dbx_business_glossary_term' = 'Sport Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `accreditation_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Support Flag');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `annual_circulation_count` SET TAGS ('dbx_business_glossary_term' = 'Annual Circulation Count');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `average_publication_year` SET TAGS ('dbx_business_glossary_term' = 'Average Publication Year');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Name');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|archived|deaccessioned');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Type');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `collection_type` SET TAGS ('dbx_value_regex' = 'general|special|archival|digital|oer|reserve');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `digital_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Access Flag');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `donor_funded_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Funded Flag');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `duplication_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Duplication Rate Percentage');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Notes');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `policy_url` SET TAGS ('dbx_business_glossary_term' = 'Collection Development Policy URL');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `policy_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `primary_lc_class` SET TAGS ('dbx_business_glossary_term' = 'Primary Library of Congress (LC) Classification');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `primary_lc_class` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}$');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `primary_location_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Location Code');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `primary_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,10}$');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `review_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Years');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `special_access_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Access Required Flag');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `subject_scope` SET TAGS ('dbx_business_glossary_term' = 'Subject Scope');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `total_title_count` SET TAGS ('dbx_business_glossary_term' = 'Total Title Count');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `usage_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Usage Rate Percentage');
ALTER TABLE `education_ecm`.`library`.`collection` ALTER COLUMN `weeding_candidate_count` SET TAGS ('dbx_business_glossary_term' = 'Weeding Candidate Count');
ALTER TABLE `education_ecm`.`library`.`research_support_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`research_support_request` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `research_support_request_id` SET TAGS ('dbx_business_glossary_term' = 'Research Support Request ID');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Librarian ID');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `patron_id` SET TAGS ('dbx_business_glossary_term' = 'Patron ID');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `citation_style` SET TAGS ('dbx_business_glossary_term' = 'Citation Style');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `citation_style` SET TAGS ('dbx_value_regex' = 'APA|MLA|Chicago|IEEE|AMA|Harvard');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `data_management_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Data Management Plan Required');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `grant_funded` SET TAGS ('dbx_business_glossary_term' = 'Grant Funded');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `irb_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Protocol Number');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `open_educational_resource_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resource (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `request_description` SET TAGS ('dbx_business_glossary_term' = 'Request Description');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'submitted|assigned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `requester_type` SET TAGS ('dbx_business_glossary_term' = 'Requester Type');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `requester_type` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|faculty|staff|postdoc|visiting_scholar');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `research_project_title` SET TAGS ('dbx_business_glossary_term' = 'Research Project Title');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `resources_provided` SET TAGS ('dbx_business_glossary_term' = 'Resources Provided');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Rating');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `scholarly_communication_topic` SET TAGS ('dbx_business_glossary_term' = 'Scholarly Communication Topic');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'research_consultation|instruction_session|systematic_review_support|data_management_plan_review|citation_management|literature_search');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `session_format` SET TAGS ('dbx_business_glossary_term' = 'Session Format');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `session_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid|asynchronous');
ALTER TABLE `education_ecm`.`library`.`research_support_request` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Subject Area');
ALTER TABLE `education_ecm`.`library`.`usage_stat` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`library`.`usage_stat` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `usage_stat_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Statistic Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `electronic_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `enterprise_application_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Enterprise Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `access_method` SET TAGS ('dbx_business_glossary_term' = 'Access Method');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `access_method` SET TAGS ('dbx_value_regex' = 'Regular|TDM');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'Controlled|OA_Gold|OA_Delayed|Other_Free_To_Read');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `cost_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost in Local Currency');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `cost_in_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'SUSHI|Manual_Upload|Vendor_Portal|Email');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `doi` SET TAGS ('dbx_business_glossary_term' = 'Digital Object Identifier (DOI)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `isbn` SET TAGS ('dbx_business_glossary_term' = 'International Standard Book Number (ISBN)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `limit_exceeded_requests` SET TAGS ('dbx_business_glossary_term' = 'Limit Exceeded Requests');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'COUNTER Metric Type');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `no_license_requests` SET TAGS ('dbx_business_glossary_term' = 'No License Requests');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `online_issn` SET TAGS ('dbx_business_glossary_term' = 'Online International Standard Serial Number (ISSN)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `parent_data_type` SET TAGS ('dbx_business_glossary_term' = 'Parent Data Type');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `parent_data_type` SET TAGS ('dbx_value_regex' = 'Book|Journal|Database');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `parent_title` SET TAGS ('dbx_business_glossary_term' = 'Parent Title');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `print_issn` SET TAGS ('dbx_business_glossary_term' = 'Print International Standard Serial Number (ISSN)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `proprietary_identifier` SET TAGS ('dbx_business_glossary_term' = 'Proprietary Identifier (ID)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `publisher` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `searches_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Searches');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `searches_federated` SET TAGS ('dbx_business_glossary_term' = 'Federated Searches');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `searches_regular` SET TAGS ('dbx_business_glossary_term' = 'Regular Searches');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `section_type` SET TAGS ('dbx_business_glossary_term' = 'Section Type');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `section_type` SET TAGS ('dbx_value_regex' = 'Article|Book|Chapter|Section|Other');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `sushi_harvest_date` SET TAGS ('dbx_business_glossary_term' = 'Standardized Usage Statistics Harvesting Initiative (SUSHI) Harvest Date');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `total_item_investigations` SET TAGS ('dbx_business_glossary_term' = 'Total Item Investigations');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `total_item_requests` SET TAGS ('dbx_business_glossary_term' = 'Total Item Requests');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `unique_item_investigations` SET TAGS ('dbx_business_glossary_term' = 'Unique Item Investigations');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `unique_item_requests` SET TAGS ('dbx_business_glossary_term' = 'Unique Item Requests');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `unique_title_investigations` SET TAGS ('dbx_business_glossary_term' = 'Unique Title Investigations');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `unique_title_requests` SET TAGS ('dbx_business_glossary_term' = 'Unique Title Requests');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `uri` SET TAGS ('dbx_business_glossary_term' = 'Uniform Resource Identifier (URI)');
ALTER TABLE `education_ecm`.`library`.`usage_stat` ALTER COLUMN `yop` SET TAGS ('dbx_business_glossary_term' = 'Year of Publication (YOP)');
ALTER TABLE `education_ecm`.`library`.`subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`subscription` SET TAGS ('dbx_subdomain' = 'resource_acquisition');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `electronic_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Resource Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Selector Identifier');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `library_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Code Identifier');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `library_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Identifier');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `access_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Access Verification Status');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `access_verification_status` SET TAGS ('dbx_value_regex' = 'verified|failed|pending|not_tested');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `cancellation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Deadline');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `collection_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Code');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `last_access_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Access Verification Date');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `oer_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Educational Resources (OER) Flag');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|one_time');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `perpetual_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Perpetual Access Flag');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Subject Area');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|pending|cancelled|expired|trial');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'print|online|combined|database|e-book_package');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `education_ecm`.`library`.`subscription` ALTER COLUMN `trial_subscription_flag` SET TAGS ('dbx_business_glossary_term' = 'Trial Subscription Flag');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` SET TAGS ('dbx_association_edges' = 'library.collection,compliance.policy');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `collection_policy_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Policy Compliance Identifier');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Policy Compliance - Collection Id');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Policy Compliance - Policy Id');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `exception_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `exception_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `policy_application_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Application Date');
ALTER TABLE `education_ecm`.`library`.`collection_policy_compliance` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` SET TAGS ('dbx_association_edges' = 'library.electronic_resource,compliance.regulatory_requirement');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `resource_compliance_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Compliance Verification Identifier');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `electronic_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Compliance Verification - Electronic Resource Id');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Compliance Verification - Regulatory Requirement Id');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `responsible_staff` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Member');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Verification Date');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `education_ecm`.`library`.`resource_compliance_verification` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `education_ecm`.`library`.`service_desk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`service_desk` SET TAGS ('dbx_subdomain' = 'patron_services');
ALTER TABLE `education_ecm`.`library`.`service_desk` ALTER COLUMN `service_desk_id` SET TAGS ('dbx_business_glossary_term' = 'Service Desk Identifier');
ALTER TABLE `education_ecm`.`library`.`service_desk` ALTER COLUMN `parent_service_desk_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`library`.`service_desk` ALTER COLUMN `staff_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`service_desk` ALTER COLUMN `staff_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`library`.`service_desk` ALTER COLUMN `staff_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`service_desk` ALTER COLUMN `staff_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`platform` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`platform` SET TAGS ('dbx_subdomain' = 'electronic_access');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `parent_platform_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `support_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `support_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `sushi_api_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `sushi_api_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`library`.`platform` ALTER COLUMN `sushi_requestor_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`publisher` SET TAGS ('dbx_subdomain' = 'resource_acquisition');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `publisher_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Identifier');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`publisher` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`library`.`library` SET TAGS ('dbx_subdomain' = 'catalog_management');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `library_id` SET TAGS ('dbx_business_glossary_term' = 'Library Identifier');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `parent_library_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`library`.`library` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
