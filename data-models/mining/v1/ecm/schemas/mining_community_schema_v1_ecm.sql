-- Schema for Domain: community | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`community` COMMENT 'Manages stakeholder engagement, community relations, social impact assessments, land compensation agreements, community investment programs, and social licence to operate. Tracks grievance mechanisms, community meetings, and benefit-sharing arrangements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`community`.`stakeholder` (
    `stakeholder_id` BIGINT COMMENT 'Unique identifier for the community stakeholder. Primary key for the stakeholder register.',
    `parent_stakeholder_id` BIGINT COMMENT 'Self-referencing FK on stakeholder (parent_stakeholder_id)',
    `benefit_sharing_arrangement` STRING COMMENT 'Type of benefit-sharing mechanism in place with the stakeholder. May include royalty payments, employment quotas for community members, infrastructure investments, community development funds, or equity participation in mining operations.. Valid values are `none|royalty_payment|employment_quota|infrastructure_investment|community_fund|equity_participation`',
    `contact_email` STRING COMMENT 'Primary email address for formal communications with the stakeholder organisation or representative.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person or representative for the stakeholder entity. May be a community elder, tribal leader, NGO director, or government official.',
    `contact_phone` STRING COMMENT 'Primary phone number for reaching the stakeholder contact person or organisation office.',
    `cultural_considerations` STRING COMMENT 'Free-text field documenting important cultural protocols, sensitivities, sacred sites, ceremonial periods, or traditional practices that must be respected during engagement. Critical for indigenous groups and traditional communities.',
    `engagement_frequency_required` STRING COMMENT 'Minimum required frequency of formal engagement with the stakeholder based on their influence level, interest level, and regulatory requirements. High-influence indigenous groups may require monthly engagement, while tertiary stakeholders may only need annual updates.. Valid values are `weekly|monthly|quarterly|biannual|annual|ad_hoc`',
    `engagement_status` STRING COMMENT 'Current state of engagement relationship with the stakeholder. Active indicates ongoing engagement, inactive for dormant relationships, pending for newly identified stakeholders awaiting first contact, suspended for temporarily paused engagement, closed for permanently concluded relationships.. Valid values are `active|inactive|pending|suspended|closed`',
    `fpic_obtained_date` DATE COMMENT 'Date on which Free Prior and Informed Consent was formally obtained from the indigenous stakeholder group. Critical compliance milestone for indigenous engagement.',
    `fpic_status` STRING COMMENT 'Status of Free Prior and Informed Consent process for indigenous stakeholders. Not required for non-indigenous stakeholders, pending for identified need, in progress for active consultation, obtained for granted consent, withheld for refused consent.. Valid values are `not_required|pending|in_progress|obtained|withheld`',
    `geographic_location` STRING COMMENT 'Primary geographic location or region where the stakeholder community is based. May include village name, district, province, or traditional land boundaries for indigenous groups.',
    `grievance_mechanism_registered` BOOLEAN COMMENT 'Indicates whether the stakeholder has been formally registered in the grievance and complaints management system and informed of their rights to raise concerns.',
    `indigenous_status` BOOLEAN COMMENT 'Indicates whether the stakeholder is an indigenous or aboriginal group with native title or traditional ownership rights. Critical for compliance with indigenous rights frameworks and free prior informed consent protocols.',
    `influence_level` STRING COMMENT 'Assessment of the stakeholders ability to affect project outcomes, regulatory approvals, or social licence to operate. High influence stakeholders can significantly impact operations through regulatory authority, community mobilisation, or media influence.. Valid values are `high|medium|low`',
    `interest_level` STRING COMMENT 'Assessment of the stakeholders level of concern or interest in mining operations and their outcomes. High interest indicates direct impact on livelihoods, land, or community wellbeing.. Valid values are `high|medium|low`',
    `land_compensation_agreement_status` STRING COMMENT 'Status of land compensation or benefit-sharing agreements with the stakeholder. Not applicable for stakeholders without land claims, in negotiation for active discussions, executed for signed agreements, completed for fully delivered compensation, disputed for contested arrangements.. Valid values are `not_applicable|in_negotiation|executed|completed|disputed`',
    `last_engagement_date` DATE COMMENT 'Date of the most recent formal engagement activity with the stakeholder, including meetings, consultations, community forums, or site visits.',
    `last_updated_date` DATE COMMENT 'Date when the stakeholder record was last modified or updated with new information.',
    `media_profile` STRING COMMENT 'Assessment of the stakeholders media presence and ability to influence public opinion. High media profile stakeholders can generate significant press coverage and shape public perception of mining operations.. Valid values are `none|low|medium|high`',
    `next_scheduled_engagement_date` DATE COMMENT 'Date of the next planned engagement activity with the stakeholder. Used for engagement planning and ensuring regular consultation frequency.',
    `notes` STRING COMMENT 'Free-text field for additional context, historical background, relationship history, or other relevant information about the stakeholder that does not fit structured fields.',
    `opposition_level` STRING COMMENT 'Current stance of the stakeholder toward mining operations. Supportive indicates endorsement, neutral indicates no strong position, concerned indicates reservations but not opposition, opposed indicates disagreement with operations, actively opposed indicates organised resistance or advocacy against the project.. Valid values are `supportive|neutral|concerned|opposed|actively_opposed`',
    `population_size` STRING COMMENT 'Estimated number of individuals represented by this stakeholder entity. For communities, total population count. For organisations, number of members or constituents represented.',
    `postal_address` STRING COMMENT 'Full postal address for written correspondence with the stakeholder entity or representative.',
    `preferred_communication_channel` STRING COMMENT 'Stakeholders preferred method for receiving communications and engagement. In-person meetings and community forums are common for indigenous and local communities, while email and phone may be preferred by NGOs and government bodies. [ENUM-REF-CANDIDATE: in_person_meeting|community_forum|phone|email|letter|radio|sms — 7 candidates stripped; promote to reference product]',
    `primary_language` STRING COMMENT 'Primary language spoken by the stakeholder community or organisation. Critical for culturally appropriate communication and translation requirements.',
    `proximity_to_operations_km` DECIMAL(18,2) COMMENT 'Distance in kilometers from the stakeholders primary location to the nearest mine site boundary. Used to assess direct impact zones and prioritise engagement intensity.',
    `registration_date` DATE COMMENT 'Date when the stakeholder was first identified and registered in the stakeholder management system.',
    `social_investment_recipient` BOOLEAN COMMENT 'Indicates whether the stakeholder is a recipient of community investment programs such as education, health, infrastructure, or livelihood support initiatives funded by the mining operation.',
    `social_licence_risk_rating` STRING COMMENT 'Assessment of the risk this stakeholder poses to the mining operations social licence to operate. Critical rating indicates stakeholder opposition could halt operations, high indicates significant project delays possible, medium indicates manageable concerns, low indicates supportive or neutral stance.. Valid values are `low|medium|high|critical`',
    `stakeholder_category` STRING COMMENT 'Hierarchical classification based on proximity to operations and impact level. Primary stakeholders are directly affected by mining activities, secondary are indirectly affected, key stakeholders have significant influence, tertiary have minimal direct impact.. Valid values are `primary|secondary|key|tertiary`',
    `stakeholder_name` STRING COMMENT 'Full legal or registered name of the stakeholder entity or individual. For indigenous groups, traditional community names. For NGOs and government bodies, official registered name.',
    `stakeholder_type` STRING COMMENT 'Primary classification of the stakeholder entity. Distinguishes between local communities, indigenous groups, individual landowners, non-governmental organisations, government bodies, and advocacy organisations.. Valid values are `local_community|indigenous_group|landowner|ngo|government_body|advocacy_organisation`',
    `traditional_owner_status` BOOLEAN COMMENT 'Indicates whether the stakeholder holds traditional ownership or native title rights over land affected by mining operations. Used to identify parties requiring specific consultation and consent protocols.',
    CONSTRAINT pk_stakeholder PRIMARY KEY(`stakeholder_id`)
) COMMENT 'Master register of all community stakeholders engaged by the mining operation, including local communities, indigenous groups, landowners, NGOs, government bodies, and advocacy organisations. Captures stakeholder identity, classification, geographic association, influence level, interest level, engagement status, preferred communication channels, and cultural considerations. Serves as the SSOT for all community-facing parties distinct from commercial counterparties in the customer domain.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`stakeholder_contact` (
    `stakeholder_contact_id` BIGINT COMMENT 'Unique identifier for the stakeholder contact record. Primary key.',
    `stakeholder_id` BIGINT COMMENT 'Reference to the parent stakeholder organisation or community group this contact person is affiliated with.',
    `reports_to_stakeholder_contact_id` BIGINT COMMENT 'Self-referencing FK on stakeholder_contact (reports_to_stakeholder_contact_id)',
    `agreement_signatory_flag` BOOLEAN COMMENT 'Indicates whether this contact person is authorised to sign formal agreements, compensation arrangements, or benefit-sharing contracts on behalf of their organisation.',
    `authorisation_level` STRING COMMENT 'Level of authority this contact person holds for signing agreements, making decisions, or representing their organisation in formal negotiations.. Valid values are `signatory|decision_maker|advisor|representative|observer|none`',
    `compensation_recipient_flag` BOOLEAN COMMENT 'Indicates whether this contact person is a recipient of land compensation, resettlement payments, or other financial benefits from the mining operation.',
    `consent_date` DATE COMMENT 'Date on which the contact person provided consent to be contacted and have their information stored in the stakeholder engagement system.',
    `consent_to_contact_flag` BOOLEAN COMMENT 'Indicates whether the contact person has provided explicit consent to be contacted for engagement purposes. Ensures compliance with privacy and data protection regulations.',
    `contact_family_name` STRING COMMENT 'Family name (surname) of the contact person.',
    `contact_full_name` STRING COMMENT 'Full legal name of the individual contact person representing the stakeholder organisation or community group.',
    `contact_given_name` STRING COMMENT 'Given name (first name) of the contact person.',
    `contact_status` STRING COMMENT 'Current status of the contact person in the stakeholder engagement system. Tracks whether the contact is actively engaged or no longer available.. Valid values are `active|inactive|retired|deceased|relocated`',
    `contact_type` STRING COMMENT 'Classification of the contact person based on their role in stakeholder engagement (e.g., primary liaison, secondary contact, emergency contact, technical advisor, legal representative).. Valid values are `primary|secondary|emergency|technical|legal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stakeholder contact record was first created in the system.',
    `cultural_protocol_notes` STRING COMMENT 'Free-text notes documenting cultural protocols, customs, or sensitivities to observe when engaging with this contact person (e.g., gender-specific engagement requirements, ceremonial considerations, appropriate meeting times).',
    `data_retention_expiry_date` DATE COMMENT 'Date on which this contact record is scheduled for review or deletion in accordance with data retention policies and privacy regulations.',
    `employment_status_with_company` STRING COMMENT 'Indicates whether the contact person is currently or was previously employed by the mining company, or is a contractor. Used to identify potential conflicts of interest or dual relationships.. Valid values are `current_employee|former_employee|contractor|not_employed`',
    `engagement_history_summary` STRING COMMENT 'High-level summary of past engagement activities, meetings, and interactions with this contact person. Provides context for relationship continuity.',
    `gender` STRING COMMENT 'Gender of the contact person. Captured to support culturally appropriate engagement practices and gender-sensitive consultation requirements.. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `grievance_lodged_flag` BOOLEAN COMMENT 'Indicates whether this contact person has lodged a formal grievance or complaint through the grievance mechanism. Used to flag sensitive relationships requiring careful management.',
    `indigenous_status` BOOLEAN COMMENT 'Indicates whether the contact person identifies as a member of an indigenous or traditional community. Used to ensure compliance with Free Prior and Informed Consent (FPIC) requirements.',
    `influence_level` STRING COMMENT 'Assessment of the contact persons level of influence within their community or organisation. Used for stakeholder prioritisation and engagement planning.. Valid values are `high|medium|low`',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether an interpreter or translator is required for effective communication with this contact person.',
    `last_contact_date` DATE COMMENT 'Date of the most recent engagement activity or communication with this contact person. Used to track relationship currency and identify contacts requiring re-engagement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this stakeholder contact record was last updated or modified.',
    `mobile_phone` STRING COMMENT 'Mobile telephone number for the contact person, used for urgent or field-based communication.',
    `next_scheduled_contact_date` DATE COMMENT 'Date of the next planned engagement activity or meeting with this contact person. Supports proactive relationship management.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about the contact person that do not fit into structured fields.',
    `office_phone` STRING COMMENT 'Office or business telephone number for the contact person.',
    `postal_address` STRING COMMENT 'Full postal mailing address for the contact person, used for formal correspondence and document delivery.',
    `preferred_contact_method` STRING COMMENT 'Preferred method of communication for this contact person (e.g., email, phone, in-person meetings, postal mail).. Valid values are `email|phone|mobile|in_person|postal_mail`',
    `preferred_language` STRING COMMENT 'Preferred language for communication with this contact person. Uses ISO 639-1 two-letter language codes (e.g., EN, FR, ES) or full language names for indigenous languages.',
    `preferred_meeting_location` STRING COMMENT 'Preferred location for face-to-face meetings with this contact person (e.g., community hall, mine site office, traditional meeting place).',
    `primary_email` STRING COMMENT 'Primary email address for contacting this individual. Main channel for formal communication and engagement correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone number for reaching the contact person. Includes country code and area code.',
    `relationship_strength_score` STRING COMMENT 'Qualitative score (1-10) assessing the strength and quality of the relationship with this contact person. Used for social licence to operate risk assessment.',
    `role_title` STRING COMMENT 'Job title or role of the contact person within their organisation or community group (e.g., Chief, Elder, President, Community Liaison Officer).',
    `secondary_email` STRING COMMENT 'Alternative email address for the contact person, used for backup communication or personal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `traditional_owner_flag` BOOLEAN COMMENT 'Indicates whether the contact person is recognised as a traditional owner or custodian of land affected by mining operations. Critical for land access and compensation negotiations.',
    CONSTRAINT pk_stakeholder_contact PRIMARY KEY(`stakeholder_contact_id`)
) COMMENT 'Individual contact persons associated with a stakeholder organisation or community group. Captures contact name, role/title, organisation affiliation, contact details, language preference, cultural protocols, engagement history summary, and authorisation level for agreements. Supports targeted engagement and relationship management at the individual level.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`engagement_plan` (
    `engagement_plan_id` BIGINT COMMENT 'Unique identifier for the stakeholder engagement plan record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Engagement plan execution costs are charged to community relations cost centers for budget control and stakeholder engagement expenditure tracking.',
    `mine_site_id` BIGINT COMMENT 'Identifier of the mine site or operational facility to which this engagement plan applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Engagement plans require a named company employee as accountable officer for stakeholder engagement execution, reporting, and escalation. Enables performance tracking and succession planning for commu',
    `social_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to community.social_impact_assessment. Business justification: Engagement plans are often developed to implement SIA recommendations and commitments. Currently sia_reference_number and sia_commitment_alignment are text fields. Adding FK enables tracking which eng',
    `superseded_engagement_plan_id` BIGINT COMMENT 'Self-referencing FK on engagement_plan (superseded_engagement_plan_id)',
    `approval_date` DATE COMMENT 'The date when the engagement plan was formally approved by management or the community relations committee.',
    `approved_by_name` STRING COMMENT 'Full name of the manager or executive who approved the engagement plan.',
    `benefit_sharing_arrangement` STRING COMMENT 'Description of benefit-sharing arrangements and community investment programs associated with this engagement plan including royalty agreements, employment commitments, and local procurement initiatives.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated for executing the engagement plan activities including meetings, events, materials, and community investment programs.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount.. Valid values are `^[A-Z]{3}$`',
    `communication_language` STRING COMMENT 'Primary language(s) to be used for stakeholder communication and engagement materials to ensure accessibility and cultural appropriateness.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the engagement plan record was first created in the system.',
    `cultural_considerations` STRING COMMENT 'Documentation of specific cultural protocols, sensitivities, and considerations that must be observed during stakeholder engagement to ensure respectful and appropriate interaction.',
    `engagement_frequency` STRING COMMENT 'Planned frequency of engagement activities with target stakeholder groups defining the cadence of interaction and communication. [ENUM-REF-CANDIDATE: daily|weekly|fortnightly|monthly|quarterly|semi_annual|annual|ad_hoc|event_driven — 9 candidates stripped; promote to reference product]',
    `engagement_methods` STRING COMMENT 'Description of the engagement methods and channels to be employed including community meetings, site visits, surveys, focus groups, public consultations, grievance mechanisms, and digital communication platforms.',
    `engagement_objectives` STRING COMMENT 'Detailed description of the strategic objectives and intended outcomes of the stakeholder engagement plan aligned to Social Impact Assessment (SIA) commitments and social licence to operate requirements.',
    `engagement_plan_status` STRING COMMENT 'Current lifecycle status of the engagement plan indicating its approval and execution state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `fpic_process_required` BOOLEAN COMMENT 'Indicates whether Free Prior and Informed Consent process is required for this engagement plan in accordance with indigenous peoples rights and international standards.',
    `grievance_mechanism_linked` BOOLEAN COMMENT 'Indicates whether this engagement plan is linked to and supports the operation of a formal grievance mechanism for stakeholder feedback and complaint resolution.',
    `indigenous_engagement_flag` BOOLEAN COMMENT 'Indicates whether this engagement plan specifically addresses engagement with indigenous peoples and requires Free Prior and Informed Consent (FPIC) processes.',
    `land_compensation_linked` BOOLEAN COMMENT 'Indicates whether this engagement plan is associated with land acquisition, resettlement, or compensation agreements requiring specific stakeholder consultation and negotiation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the engagement plan record was last modified or updated.',
    `last_review_date` DATE COMMENT 'The date when the engagement plan was last reviewed and assessed for effectiveness and alignment with current stakeholder needs.',
    `next_review_date` DATE COMMENT 'The date when the next scheduled review of the engagement plan is due.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the engagement plan including lessons learned, stakeholder feedback, and implementation challenges.',
    `plan_code` STRING COMMENT 'Unique business identifier code for the engagement plan used for external reference and reporting.. Valid values are `^EP-[A-Z0-9]{6,12}$`',
    `plan_title` STRING COMMENT 'Descriptive title of the stakeholder engagement plan identifying its purpose and scope.',
    `plan_type` STRING COMMENT 'Classification of the engagement plan based on its strategic purpose and scope within the community relations framework.. Valid values are `strategic|operational|project_specific|issue_response|ongoing|closure`',
    `planning_period_end_date` DATE COMMENT 'The date when the engagement plan period concludes. May be null for ongoing engagement plans without defined end dates.',
    `planning_period_start_date` DATE COMMENT 'The date when the engagement plan period commences and planned activities begin execution.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and updating the engagement plan to ensure continued relevance and effectiveness.. Valid values are `monthly|quarterly|semi_annual|annual|ad_hoc`',
    `risk_level` STRING COMMENT 'Assessment of the stakeholder risk level associated with this engagement plan based on potential for conflict, social licence threats, and community opposition.. Valid values are `low|medium|high|critical`',
    `sia_commitment_alignment` STRING COMMENT 'Description of how this engagement plan aligns with and fulfills specific commitments made in the Social Impact Assessment and Environmental Impact Statement (EIS).',
    `sia_reference_number` STRING COMMENT 'Reference number of the Social Impact Assessment document to which this engagement plan is aligned and from which commitments are derived.',
    `success_metrics` STRING COMMENT 'Definition of success metrics and Key Performance Indicators (KPIs) used to measure the effectiveness of the engagement plan including participation rates, satisfaction scores, and grievance resolution times.',
    `target_stakeholder_groups` STRING COMMENT 'Identification of the specific stakeholder groups and communities targeted by this engagement plan including indigenous communities, local residents, government authorities, NGOs, and other affected parties.',
    CONSTRAINT pk_engagement_plan PRIMARY KEY(`engagement_plan_id`)
) COMMENT 'Master record of structured stakeholder engagement plans defining the strategy, objectives, frequency, methods, and responsible personnel for engaging specific stakeholder groups over a defined period. Captures plan title, planning period, engagement objectives, target stakeholder groups, engagement methods (meetings, surveys, site visits), responsible community liaison officer, approval status, and alignment to Social Impact Assessment commitments. Drives proactive community relations management.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`meeting` (
    `meeting_id` BIGINT COMMENT 'Unique identifier for the community meeting record. Primary key for the community meeting entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Community consultation meetings often discuss specific equipment activities (haul trucks using public roads, drill rigs operating near villages, blasting equipment timing, conveyor noise). Stakeholder',
    `engagement_plan_id` BIGINT COMMENT 'Foreign key linking to community.engagement_plan. Business justification: Meetings are often conducted as part of structured engagement plans. The meeting has consultation_phase and engagement_topic_category attributes suggesting it may be part of a planned engagement strat',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When company employees facilitate community meetings (common in Mining), tracking the facilitator enables performance assessment, continuity planning, and cultural competency development for community',
    `site_id` BIGINT COMMENT 'Foreign key reference to the mine site or operational facility associated with this community meeting. Links to the site master data.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key reference to the primary stakeholder group or community organization participating in the meeting. Links to stakeholder master data.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Community meetings frequently discuss specific tenement activities, exploration plans, or operational impacts. Essential for tracking consultation obligations, FPIC processes, and stakeholder engageme',
    `follow_up_meeting_id` BIGINT COMMENT 'Self-referencing FK on meeting (follow_up_meeting_id)',
    `agenda_summary` STRING COMMENT 'High-level summary of the meeting agenda items and topics discussed. Provides context for the consultation session.',
    `attendee_count` STRING COMMENT 'Total number of community members and stakeholders who attended the meeting. Used for engagement metrics and Social Licence to Operate (SLO) reporting.',
    `commitments_made` STRING COMMENT 'Summary of commitments, promises, or action items that the company agreed to during the meeting. Forms the basis for follow-up tracking and accountability.',
    `company_representative_count` STRING COMMENT 'Number of company employees and representatives who attended the meeting on behalf of the mining operation.',
    `consultation_phase` STRING COMMENT 'The Life of Mine (LOM) phase during which the community meeting was conducted. Aligns engagement activities with project lifecycle stages.. Valid values are `exploration|feasibility|construction|operations|closure|post_closure`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this community meeting record was first created in the system. Audit trail for data lineage.',
    `end_time` TIMESTAMP COMMENT 'The precise date and time when the community meeting concluded. Used for duration calculation and resource planning.',
    `engagement_topic_category` STRING COMMENT 'Primary thematic category of the meeting content. Used for topic-based analysis and reporting of stakeholder concerns.. Valid values are `environmental|social|economic|health_safety|land_access|resettlement`',
    `facilitator_organization` STRING COMMENT 'The organization or company that the facilitator represents (e.g., mining company, independent consultant, government agency).',
    `follow_up_action_status` STRING COMMENT 'Current status of follow-up actions and commitments arising from the meeting. Tracks closure of action items for Social Licence to Operate (SLO) compliance.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up actions and commitments from the meeting should be completed. Used for action tracking and accountability.',
    `government_official_present_flag` BOOLEAN COMMENT 'Indicates whether government officials or regulatory representatives attended the meeting. Important for regulatory compliance and stakeholder mapping.',
    `grievance_logged_flag` BOOLEAN COMMENT 'Indicates whether any formal grievances were logged or escalated during this meeting. Triggers grievance mechanism workflow.',
    `key_issues_raised` STRING COMMENT 'Summary of the primary concerns, questions, and issues raised by community stakeholders during the meeting. Critical for grievance tracking and Social Licence to Operate (SLO) management.',
    `language_used` STRING COMMENT 'Primary language(s) used during the community meeting. Important for cultural sensitivity and accessibility compliance.',
    `last_modified_by` STRING COMMENT 'User ID or name of the individual who last modified this community meeting record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this community meeting record was last updated in the system. Audit trail for change tracking.',
    `location_address` STRING COMMENT 'The full physical address of the meeting venue. Organizational contact data classified as confidential.',
    `location_coordinates` STRING COMMENT 'Geographic coordinates (latitude, longitude) of the meeting venue in decimal degrees format. Used for Geographic Information System (GIS) mapping and spatial analysis.. Valid values are `^-?[0-9]{1,3}.[0-9]{4,10},-?[0-9]{1,3}.[0-9]{4,10}$`',
    `location_name` STRING COMMENT 'The name of the venue or facility where the community meeting was held (e.g., community hall, mine site office, village center).',
    `media_present_flag` BOOLEAN COMMENT 'Indicates whether media representatives (press, journalists, broadcasters) were present at the meeting. Important for public relations and communications management.',
    `meeting_date` DATE COMMENT 'The calendar date on which the community meeting was held or is scheduled to be held. Principal business event timestamp for consultation tracking.',
    `meeting_status` STRING COMMENT 'Current lifecycle status of the community meeting. Tracks progression from planning through completion or cancellation.. Valid values are `scheduled|in_progress|completed|cancelled|postponed`',
    `meeting_type` STRING COMMENT 'Classification of the community meeting format. Determines the engagement approach and documentation requirements for Social Licence to Operate (SLO) compliance.. Valid values are `public_consultation|focus_group|bilateral|site_visit|town_hall|grievance_hearing`',
    `minutes_document_reference` STRING COMMENT 'Reference identifier or file path to the official meeting minutes document. Links to the document management system for full meeting record retrieval.',
    `notes` STRING COMMENT 'Additional notes, observations, or context captured during or after the meeting. Supplements formal minutes with qualitative insights.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the community meeting for tracking and audit purposes. Format typically includes site code, year, and sequence number.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{4,6}$`',
    `slo_risk_level` STRING COMMENT 'Assessment of the Social Licence to Operate (SLO) risk level based on issues raised and stakeholder sentiment during the meeting. Used for risk management and escalation.. Valid values are `low|medium|high|critical`',
    `start_time` TIMESTAMP COMMENT 'The precise date and time when the community meeting commenced. Used for duration calculation and scheduling coordination.',
    `translation_provided_flag` BOOLEAN COMMENT 'Indicates whether translation or interpretation services were provided during the meeting to accommodate non-native speakers.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this community meeting record in the system. Audit trail for accountability.',
    CONSTRAINT pk_meeting PRIMARY KEY(`meeting_id`)
) COMMENT 'Transactional record of each community meeting, consultation session, or public forum conducted with stakeholder groups. Captures meeting date, location, meeting type (public consultation, focus group, bilateral, site visit), attendees, agenda items, key issues raised, commitments made, minutes reference, facilitator, and follow-up action status. Provides the audit trail for social licence to operate (SLO) consultation obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Unique identifier for the grievance record. Primary key for the grievance entity.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Grievances are lodged BY stakeholders (community members, landowners, traditional owners). The grievance currently stores complainant details as denormalized attributes. Adding complainant_stakeholder',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Community grievances (dust, noise, water quality complaints) generate HSE corrective actions in mining operations. Tracks which corrective action addresses each grievance for closure verification and ',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_program. Business justification: Drilling activities generate community grievances (noise, dust, water contamination, access disruption). Tracking which drill program caused which grievance is essential for root cause analysis, corre',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or community relations officer assigned to manage and resolve the grievance.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Mining operations track community grievances about specific equipment (noise from haul trucks, dust from drill rigs, vibration from blasting equipment near settlements). Grievance management systems r',
    `site_id` BIGINT COMMENT 'Identifier of the mining site or operation implicated in the grievance.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Grievances often relate to specific tenement operations (noise, dust, land access). Critical for tracking social licence risks, regulatory compliance, and operational impact management at the tenement',
    `related_grievance_id` BIGINT COMMENT 'Self-referencing FK on grievance (related_grievance_id)',
    `acknowledgement_date` DATE COMMENT 'Date when the grievance receipt was formally acknowledged to the complainant. Required under IFC Performance Standard 1 grievance mechanism protocols.',
    `activity_implicated` STRING COMMENT 'Specific mining operation, activity, or project phase implicated in the grievance (e.g., drilling, blasting, haulage, construction, exploration).',
    `actual_resolution_date` DATE COMMENT 'Actual date when the grievance was resolved and resolution communicated to the complainant.',
    `assigned_date` DATE COMMENT 'Date when the grievance was assigned to a case officer for investigation and resolution.',
    `closure_date` DATE COMMENT 'Date when the grievance case was formally closed after resolution confirmation or withdrawal.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation amount paid or agreed to resolve the grievance, if applicable. Recorded in the operating currency of the site.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, AUD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `complainant_satisfaction_rating` STRING COMMENT 'Complainant feedback on satisfaction with the grievance handling process and resolution outcome. Collected post-resolution for grievance mechanism effectiveness monitoring.. Valid values are `very_satisfied|satisfied|neutral|dissatisfied|very_dissatisfied|not_provided`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grievance record was first created in the system. Used for audit trail and data lineage.',
    `escalation_level` STRING COMMENT 'Current escalation level of the grievance within the organizational hierarchy or external dispute resolution mechanisms.. Valid values are `site|regional|corporate|external_mediator|legal`',
    `grievance_category` STRING COMMENT 'Primary category or type of grievance. Classifies the nature of the complaint for routing, analysis, and reporting. [ENUM-REF-CANDIDATE: noise|dust|water|land_access|employment|cultural_heritage|compensation|blasting|traffic|health_safety|resettlement|environmental_damage|human_rights — promote to reference product]',
    `grievance_description` STRING COMMENT 'Detailed narrative description of the grievance as provided by the complainant. Captures the nature of the concern, impact experienced, and complainant expectations.',
    `grievance_status` STRING COMMENT 'Current lifecycle status of the grievance in the resolution process. Tracks progression from receipt through investigation to closure. [ENUM-REF-CANDIDATE: received|under_investigation|pending_response|resolved|closed|withdrawn|escalated — 7 candidates stripped; promote to reference product]',
    `investigation_completion_date` DATE COMMENT 'Date when the grievance investigation was completed and findings documented.',
    `investigation_start_date` DATE COMMENT 'Date when formal investigation of the grievance commenced.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the grievance was lodged anonymously. True if complainant identity is withheld, False if disclosed.',
    `is_repeat_grievance` BOOLEAN COMMENT 'Indicates whether this grievance is a repeat or recurrence of a previously lodged grievance by the same complainant or community. True if repeat, False if first occurrence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grievance record was last updated or modified. Used for audit trail and change tracking.',
    `location_description` STRING COMMENT 'Description of the specific location or area where the grievance issue occurred or is experienced. May reference mine infrastructure, community areas, or access routes.',
    `lodgement_channel` STRING COMMENT 'Channel or method through which the grievance was lodged. Tracks accessibility and effectiveness of grievance mechanism entry points. [ENUM-REF-CANDIDATE: in_person|phone|email|web_portal|community_meeting|suggestion_box|third_party — 7 candidates stripped; promote to reference product]',
    `lodgement_date` DATE COMMENT 'Date when the grievance was formally lodged or received by the company. Principal business event timestamp for the grievance lifecycle.',
    `lodgement_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the grievance was lodged, including time of day. Used for SLA tracking and response time calculations.',
    `reference_number` STRING COMMENT 'Externally-visible unique reference number assigned to the grievance for tracking and communication purposes. Format: GRV-YYYY-NNNNNN.. Valid values are `^GRV-[0-9]{4}-[0-9]{6}$`',
    `requires_external_mediation` BOOLEAN COMMENT 'Indicates whether the grievance requires or has been referred to external mediation or dispute resolution mechanisms. True if external mediation needed, False otherwise.',
    `resolution_description` STRING COMMENT 'Detailed description of the actions taken to resolve the grievance, including remedial measures, compensation provided, or operational changes implemented.',
    `resolution_outcome` STRING COMMENT 'Final outcome classification of the grievance resolution process. Indicates whether the grievance was resolved to complainant satisfaction.. Valid values are `resolved_satisfactorily|resolved_partially|unresolved|withdrawn|referred_external|duplicate`',
    `severity_classification` STRING COMMENT 'Severity or priority level assigned to the grievance based on impact assessment. Determines response timeframes and escalation requirements per IFC Performance Standards.. Valid values are `low|medium|high|critical`',
    `subcategory` STRING COMMENT 'Secondary classification providing additional detail on the grievance type. Allows for more granular categorization within primary categories.',
    `target_resolution_date` DATE COMMENT 'Target date for grievance resolution based on severity classification and Service Level Agreement (SLA) commitments under the grievance mechanism.',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Master record of each formal grievance, complaint, or concern lodged by a community member, landowner, or stakeholder against the mining operation. Captures grievance reference number, lodgement date, complainant details, grievance category (noise, dust, water, land access, employment, cultural heritage, compensation), site or activity implicated, severity classification, assigned case officer, current status, resolution date, and outcome. Core entity for the community grievance mechanism required under IFC Performance Standards and Equator Principles.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`grievance_action` (
    `grievance_action_id` BIGINT COMMENT 'Unique identifier for each grievance action record. Primary key for the grievance action entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Grievance resolution actions often involve specific equipment (relocating haul routes away from villages, modifying drill rig operating hours, installing dust suppression on conveyors). Action trackin',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Grievance remediation costs (compensation, mitigation measures) are charged to operational cost centers for budget tracking and community relations expenditure reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or community relations officer assigned to execute this action. Links to the workforce or employee master data.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Grievance remediation costs post to specific GL accounts (community compensation, legal settlements) for financial reporting and cost classification.',
    `grievance_id` BIGINT COMMENT 'Reference to the parent grievance case that this action is responding to. Links this action to the originating community complaint or concern.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Specific grievance actions often reference or trigger HSE corrective actions (e.g., install additional dust monitors, increase water cart frequency). Links community relations response to operational ',
    `preceding_grievance_action_id` BIGINT COMMENT 'Self-referencing FK on grievance_action (preceding_grievance_action_id)',
    `action_date` DATE COMMENT 'Date when this grievance action was taken or initiated. Represents the principal business event timestamp for this action record.',
    `action_description` STRING COMMENT 'Detailed narrative description of the action taken, including steps performed, parties involved, and any observations made during the action execution.',
    `action_location` STRING COMMENT 'Physical location where the action was conducted (e.g., mine site, community hall, complainant residence, office). Relevant for site inspections and mediation meetings.',
    `action_number` STRING COMMENT 'Business identifier for the action, typically formatted as a sequential or hierarchical code within the parent grievance (e.g., GRV-2024-001-A01).',
    `action_outcome` STRING COMMENT 'Summary of the result or finding from this action. Documents what was discovered, agreed, or resolved through this specific response activity.',
    `action_sequence` STRING COMMENT 'Sequential order of this action within the parent grievance case, enabling chronological tracking of all response activities.',
    `action_status` STRING COMMENT 'Current lifecycle status of this grievance action, tracking whether the action has been initiated, is underway, or has been finalized.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `action_timestamp` TIMESTAMP COMMENT 'Precise date and time when this grievance action was executed, providing granular tracking for time-sensitive response activities.',
    `action_type` STRING COMMENT 'Category of action taken in response to the grievance. Defines the nature of the response activity undertaken by the grievance management team. [ENUM-REF-CANDIDATE: acknowledgement|investigation|site_inspection|mediation|stakeholder_consultation|resolution_offer|closure|escalation — 8 candidates stripped; promote to reference product]',
    `actual_completion_date` DATE COMMENT 'Actual date when this action was completed, enabling measurement of grievance handling timeliness and SLA compliance.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred for this action, captured after completion. Used for budget tracking and cost-benefit analysis of grievance management programs.',
    `complainant_acceptance_flag` BOOLEAN COMMENT 'Indicates whether the complainant accepted the resolution or outcome proposed through this action. Key metric for measuring social licence to operate and grievance mechanism effectiveness.',
    `complainant_feedback` STRING COMMENT 'Free-text feedback or comments provided by the complainant regarding this action or its outcome, captured to support continuous improvement of grievance handling processes.',
    `complainant_notification_date` DATE COMMENT 'Date when the complainant was informed of this action and its outcome, supporting compliance with grievance mechanism response time commitments.',
    `complainant_notified_flag` BOOLEAN COMMENT 'Indicates whether the complainant was formally notified of this action and its outcome. Critical for transparency and procedural fairness tracking.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity and confidentiality requirements for this action record, governing access controls and disclosure permissions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this grievance action record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this action record (e.g., USD, AUD, ZAR, CLP).. Valid values are `^[A-Z]{3}$`',
    `escalation_reason` STRING COMMENT 'Explanation of why escalation was required, documenting the complexity, sensitivity, or unresolved nature of the grievance that necessitates higher-level intervention.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this action identified the need for escalation to senior management, legal, or external dispute resolution mechanisms.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost associated with this action, including compensation offers, remediation expenses, or operational costs. Enables financial tracking of grievance resolution.',
    `evidence_collected` STRING COMMENT 'Description of evidence, documentation, or materials collected during this action (e.g., photographs, witness statements, site measurements, agreements). Supports audit trail and legal defensibility.',
    `follow_up_due_date` DATE COMMENT 'Scheduled date for follow-up action or verification, ensuring that commitments made during this action are monitored and fulfilled.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether this action requires subsequent follow-up actions or monitoring to ensure sustained resolution or compliance with commitments made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this grievance action record was last updated, enabling change tracking and audit compliance.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether this action or its outcome requires legal review due to potential liability, contractual implications, or regulatory compliance considerations.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this record, supporting accountability and audit trail requirements.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context relevant to this action that do not fit into structured fields. Supports comprehensive documentation of grievance handling activities.',
    `outcome_category` STRING COMMENT 'Categorical classification of the action outcome, enabling structured reporting on grievance resolution effectiveness and patterns.. Valid values are `issue_validated|issue_not_substantiated|partial_resolution|full_resolution|no_resolution|requires_escalation`',
    `responsible_department` STRING COMMENT 'Department or functional unit responsible for this action (e.g., Community Relations, HSE, Operations, Legal). Enables departmental accountability tracking.',
    `responsible_officer_name` STRING COMMENT 'Full name of the officer responsible for executing this grievance action, captured for audit trail and accountability purposes.',
    `source_system` STRING COMMENT 'Name of the operational system from which this grievance action record originated (e.g., IsoMetrix, custom grievance management system, community engagement platform).',
    `stakeholders_consulted` STRING COMMENT 'List or description of stakeholders consulted during this action (e.g., community leaders, government officials, technical experts, legal counsel).',
    `target_completion_date` DATE COMMENT 'Planned or committed date by which this action should be completed, supporting Service Level Agreement (SLA) tracking for grievance response times.',
    CONSTRAINT pk_grievance_action PRIMARY KEY(`grievance_action_id`)
) COMMENT 'Transactional record of each investigation step, response action, or resolution activity taken against a community grievance. Captures action date, action type (acknowledgement, investigation, site inspection, mediation, resolution offer, closure), responsible officer, action description, outcome, and whether the complainant accepted the resolution. Provides the full audit trail of grievance handling from lodgement to closure.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`social_impact_assessment` (
    `social_impact_assessment_id` BIGINT COMMENT 'Unique identifier for the social impact assessment record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Reference to the mine project, expansion, or operational change being assessed for social impacts.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: SIAs reference environmental permits as they assess combined social-environmental impacts of permitted activities. Regulatory requirement in mining jurisdictions for integrated impact assessment. Link',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When SIAs are conducted by internal staff (common for baseline updates and monitoring), tracking the lead assessor ensures accountability, quality control, and competency verification for regulatory c',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Social impact assessments are prepared for specific orebodies before development. Regulatory approval process requires linking SIAs to the geological resources being developed. Real business process: ',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Social impact assessments are conducted by specialized consulting firms contracted as vendors. The lead_assessor_organisation text field should be formalized as FK to vendor for procurement compliance',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Resource estimates trigger SIA updates and inform impact magnitude predictions (employment, infrastructure, resettlement scale). Project approval and financing require linking SIAs to the resource est',
    `resource_statement_id` BIGINT COMMENT 'Foreign key linking to geology.resource_statement. Business justification: Resource statements trigger SIA requirements under mining regulations. Regulatory submissions link resource declarations to impact assessments for approval. Real business process: regulatory complianc',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: SIAs incorporate HSE risk assessments for activities affecting communities (blasting, dust, noise, water discharge). Standard practice in mining to integrate technical risk assessment into social impa',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: SIA costs for capital projects are capitalized to WBS elements. Links assessment to project budget for capital approval, cost tracking, and asset capitalization under IFRS.',
    `superseded_social_impact_assessment_id` BIGINT COMMENT 'Self-referencing FK on social_impact_assessment (superseded_social_impact_assessment_id)',
    `affected_communities` STRING COMMENT 'List or description of communities, indigenous groups, and stakeholder populations identified as directly or indirectly affected by the project.',
    `approval_authority` STRING COMMENT 'Name of the regulatory body, government agency, or internal authority that approved the social impact assessment.',
    `approval_date` DATE COMMENT 'Date on which the social impact assessment received formal approval from internal governance or regulatory authorities.',
    `assessment_completion_date` DATE COMMENT 'Date on which the social impact assessment report was finalized and delivered.',
    `assessment_reference_number` STRING COMMENT 'External reference number or document identifier assigned to this SIA for regulatory and internal tracking purposes.',
    `assessment_scope` STRING COMMENT 'Detailed description of the scope of the social impact assessment, including geographic boundaries, communities covered, and aspects evaluated.',
    `assessment_start_date` DATE COMMENT 'Date on which the social impact assessment fieldwork and data collection commenced.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the social impact assessment: draft, under review, approved, submitted to regulators, rejected, active (being implemented), or closed. [ENUM-REF-CANDIDATE: draft|under_review|approved|submitted|rejected|active|closed — 7 candidates stripped; promote to reference product]',
    `assessment_title` STRING COMMENT 'The formal title or name of the social impact assessment document.',
    `assessment_type` STRING COMMENT 'The category of social impact assessment being conducted: baseline study, impact assessment, management plan, monitoring report, closure assessment, or cumulative impact assessment.. Valid values are `baseline|impact_assessment|management_plan|monitoring_report|closure_assessment|cumulative_impact`',
    `baseline_social_conditions` STRING COMMENT 'Summary of the baseline social, economic, and cultural conditions of affected communities prior to project activities, including demographics, livelihoods, infrastructure, and cultural heritage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this social impact assessment record was first created in the system.',
    `document_location` STRING COMMENT 'File path, URL, or document management system reference where the full social impact assessment report is stored.',
    `fpic_status` STRING COMMENT 'Current status of the Free, Prior, and Informed Consent process: not applicable, not started, in progress, obtained, or not obtained.. Valid values are `not_applicable|not_started|in_progress|obtained|not_obtained`',
    `free_prior_informed_consent_required` BOOLEAN COMMENT 'Indicates whether Free, Prior, and Informed Consent (FPIC) is required from indigenous communities as part of the social impact assessment and project approval process.',
    `impact_significance_rating` STRING COMMENT 'Overall significance rating of the identified social impacts based on magnitude, duration, reversibility, and affected population: negligible, minor, moderate, major, or critical.. Valid values are `negligible|minor|moderate|major|critical`',
    `indigenous_peoples_involved` BOOLEAN COMMENT 'Indicates whether indigenous peoples or traditional landowners are among the affected stakeholders, triggering additional consultation and consent requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this social impact assessment record was last updated or modified.',
    `mitigation_measures` STRING COMMENT 'Detailed description of mitigation, management, and enhancement measures proposed to address identified negative impacts and maximize positive impacts.',
    `monitoring_commitments` STRING COMMENT 'Description of ongoing monitoring and reporting commitments to track the effectiveness of mitigation measures and the evolution of social impacts over the project lifecycle.',
    `negative_impacts_identified` STRING COMMENT 'Description of anticipated negative social impacts such as displacement, loss of livelihoods, cultural disruption, increased cost of living, health and safety risks, and social conflict.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review or update of the social impact assessment.',
    `positive_impacts_identified` STRING COMMENT 'Description of anticipated positive social impacts such as employment opportunities, infrastructure development, local procurement, and community investment benefits.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for the social impact assessment: not submitted, submitted, under review, approved, conditional approval, or rejected.. Valid values are `not_submitted|submitted|under_review|approved|conditional_approval|rejected`',
    `regulatory_submission_reference` STRING COMMENT 'Reference number or identifier for the submission of this SIA to regulatory authorities as part of Environmental Impact Statement (EIS) or permitting processes.',
    `resettlement_action_plan_reference` STRING COMMENT 'Reference number or identifier of the associated Resettlement Action Plan (RAP) if resettlement is required.',
    `resettlement_required` BOOLEAN COMMENT 'Indicates whether physical or economic displacement and resettlement of communities is required as a result of the project, triggering a Resettlement Action Plan (RAP).',
    `review_schedule` STRING COMMENT 'Planned schedule for periodic review and update of the social impact assessment, typically aligned with project phases or regulatory requirements (e.g., annual, biennial, or at major project milestones).',
    `stakeholder_engagement_summary` STRING COMMENT 'Summary of stakeholder consultation and engagement activities conducted during the assessment, including community meetings, focus groups, and feedback received.',
    CONSTRAINT pk_social_impact_assessment PRIMARY KEY(`social_impact_assessment_id`)
) COMMENT 'Master record of Social Impact Assessments (SIAs) and Social Impact Management Plans (SIMPs) conducted for mine projects, expansions, or operational changes. Captures assessment title, project or activity assessed, assessment scope, baseline social conditions, identified positive and negative impacts, impact significance ratings, mitigation measures, monitoring commitments, regulatory submission reference, approval status, and review schedule. Serves as the foundational document for social licence obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`land_compensation_agreement` (
    `land_compensation_agreement_id` BIGINT COMMENT 'Unique identifier for the land compensation agreement record. Primary key for this entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Ongoing land compensation payments (not capitalized) are operational expenditure charged to site cost centers for budget tracking and unit cost reporting.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Land compensation agreements are with specific landowners or communities who should be registered stakeholders. Currently stored as text fields (landowner_name, landowner_contact, community_name). Nor',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Land compensation agreements are negotiated for specific orebodies/mining areas. Agreements reference the orebody to determine compensation scope, duration, and payment triggers based on mining activi',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Land compensation agreements require a named company employee as accountable manager for compliance tracking, payment authorization, dispute resolution, and regulatory reporting. Critical for audit tr',
    `site_id` BIGINT COMMENT 'Identifier of the mine site, operation, or project to which this land compensation agreement is associated.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mining tenement, lease, or licence under which this land compensation agreement was negotiated.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Land compensation for mine development is capitalized to project WBS elements as pre-production capital expenditure, enabling tracking against capital budget and asset under construction.',
    `superseded_land_compensation_agreement_id` BIGINT COMMENT 'Self-referencing FK on land_compensation_agreement (superseded_land_compensation_agreement_id)',
    `agreement_duration_years` DECIMAL(18,2) COMMENT 'Duration of the agreement in years, indicating the period during which land access rights are granted and compensation obligations apply.',
    `agreement_reference` STRING COMMENT 'Externally-known unique reference number or code assigned to this land compensation agreement for tracking and legal purposes.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the land compensation agreement indicating its legal standing and operational state. [ENUM-REF-CANDIDATE: draft|under_negotiation|executed|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the land compensation agreement based on the nature of land use and access rights being negotiated.. Valid values are `surface_access|infrastructure_corridor|temporary_disturbance|permanent_acquisition|easement|right_of_way`',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of compensation payable under this agreement, expressed in the functional currency of the operation.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount (e.g., USD, AUD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `compensation_type` STRING COMMENT 'Form of compensation provided to landowners or affected communities, including monetary payments, goods, services, or livelihood support programs.. Valid values are `cash|in_kind|livelihood_restoration|infrastructure|employment|combination`',
    `compliance_status` STRING COMMENT 'Current status of the mining companys compliance with the terms and obligations of the land compensation agreement.. Valid values are `compliant|non_compliant|under_review|remediation_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this land compensation agreement record was first created in the system.',
    `cultural_heritage_provisions` STRING COMMENT 'Specific provisions for the protection, preservation, or management of cultural heritage sites, sacred sites, or artifacts within the land parcel.',
    `dispute_description` STRING COMMENT 'Description of the nature, cause, and current state of any dispute or grievance raised by the landowner or community regarding this agreement.',
    `dispute_status` STRING COMMENT 'Current status of any disputes, grievances, or legal challenges related to this land compensation agreement.. Valid values are `no_dispute|under_dispute|mediation|arbitration|litigation|resolved`',
    `document_reference` STRING COMMENT 'Reference to the physical or digital location of the signed agreement document, contract file, or legal instrument in the document management system.',
    `effective_date` DATE COMMENT 'Date on which the land compensation agreement becomes legally binding and enforceable.',
    `execution_date` DATE COMMENT 'Date on which the agreement was formally signed and executed by all parties.',
    `expiry_date` DATE COMMENT 'Date on which the land compensation agreement terminates or expires, after which land access rights and compensation obligations cease unless renewed.',
    `in_kind_description` STRING COMMENT 'Detailed description of non-monetary compensation provided, such as infrastructure development, housing, water supply, or community facilities.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this land compensation agreement is currently active and in force (True) or has been terminated, expired, or superseded (False).',
    `land_area_hectares` DECIMAL(18,2) COMMENT 'Total area of land in hectares subject to disturbance, access, or acquisition under this compensation agreement.',
    `land_parcel_reference` STRING COMMENT 'Official cadastral reference, lot number, or geographic identifier for the land parcel covered by this compensation agreement.',
    `land_use_type` STRING COMMENT 'Primary use or designation of the land prior to mining activities, relevant for determining compensation basis and restoration obligations.. Valid values are `agricultural|residential|pastoral|forest|sacred_site|cultural_heritage`',
    `last_payment_date` DATE COMMENT 'Date of the most recent compensation payment made to the landowner or community under this agreement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this land compensation agreement record was most recently modified or updated.',
    `livelihood_program_details` STRING COMMENT 'Description of livelihood restoration or alternative income generation programs provided to affected parties to maintain or improve their standard of living.',
    `negotiation_start_date` DATE COMMENT 'Date on which formal negotiations with the landowner or community commenced for this compensation agreement.',
    `payment_schedule` STRING COMMENT 'Timing and frequency of compensation payments as stipulated in the agreement terms.. Valid values are `lump_sum|annual|quarterly|milestone_based|phased`',
    `rehabilitation_obligations` STRING COMMENT 'Description of land rehabilitation, restoration, or remediation obligations the mining company must fulfill upon completion of activities or agreement termination.',
    `special_conditions` STRING COMMENT 'Any special terms, conditions, or obligations attached to the agreement, such as environmental restoration requirements, cultural heritage protections, or access restrictions.',
    `total_paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative total of all compensation payments made to the landowner or community since the agreements execution.',
    CONSTRAINT pk_land_compensation_agreement PRIMARY KEY(`land_compensation_agreement_id`)
) COMMENT 'Master record of land access and compensation agreements negotiated with landowners, traditional owners, and affected communities for surface disturbance, access corridors, and infrastructure footprints. Captures agreement reference, parties involved, land parcel details, compensation type (cash, in-kind, livelihood restoration), compensation amount, payment schedule, duration, conditions, execution date, and compliance status. Distinct from tenement.native_title_agreement which covers statutory native title instruments; this entity covers private and community compensation arrangements.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`compensation_payment` (
    `compensation_payment_id` BIGINT COMMENT 'Unique identifier for each compensation payment transaction. Primary key for the compensation payment record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Compensation payments are charged to cost centres for management accounting. The current cost_centre_code (string) should be replaced with FK to finance.cost_centre to enable proper cost allocation an',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who authorized and approved this compensation payment for disbursement. Critical for audit trail and accountability.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Compensation payments post to general ledger accounts for financial reporting. The current general_ledger_account_code (string) should be replaced with FK to finance.general_ledger_account for referen',
    `land_compensation_agreement_id` BIGINT COMMENT 'Reference to the parent land compensation agreement under which this payment is made. Links payment to the governing contractual arrangement.',
    `original_payment_compensation_payment_id` BIGINT COMMENT 'Reference to the original compensation payment record if this payment is a reversal, correction, or adjustment. Creates an audit chain for payment modifications.',
    `stakeholder_id` BIGINT COMMENT 'Reference to the landowner, community member, or entity receiving the compensation payment. Links to the counterparty or community stakeholder record.',
    `adjusted_compensation_payment_id` BIGINT COMMENT 'Self-referencing FK on compensation_payment (adjusted_compensation_payment_id)',
    `approval_date` DATE COMMENT 'The date on which this compensation payment was formally approved for disbursement. Represents a key control point in the payment lifecycle.',
    `bank_transfer_reference` STRING COMMENT 'The unique transaction reference or confirmation number provided by the banking system for electronic fund transfers. Used for payment reconciliation and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation payment record was first created in the system. Audit field tracking record inception.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was made (e.g., USD, AUD, ZAR, CLP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compensation payment record was last updated. Audit field tracking the most recent change to the record.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net monetary value actually disbursed to the payee after all deductions, withholdings, and adjustments. Represents the final amount received by the payee.',
    `payee_bank_account_number` STRING COMMENT 'The bank account number of the payee to which the compensation payment was transferred. Sensitive financial information requiring restricted access.',
    `payee_bank_branch_code` STRING COMMENT 'The branch or routing code for the payees bank account. Required for domestic and international payment processing.',
    `payee_bank_name` STRING COMMENT 'The name of the financial institution holding the payees account. Used for payment routing and verification.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the compensation payment disbursed, before any deductions or adjustments. Represents the total amount transferred to the payee.',
    `payment_date` DATE COMMENT 'The date on which the compensation payment was disbursed to the payee. Represents the actual transaction date, not the scheduled or planned date.',
    `payment_description` STRING COMMENT 'Free-text description providing additional context about the compensation payment, including purpose, special conditions, or notes for the payee.',
    `payment_failure_reason` STRING COMMENT 'Description of the reason why the payment failed, if applicable. Captures technical or business reasons for payment rejection or failure.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to disburse the compensation payment. Indicates how the funds were transferred to the payee.. Valid values are `bank_transfer|cheque|cash|mobile_money|escrow|direct_deposit`',
    `payment_period_end_date` DATE COMMENT 'The end date of the period covered by this compensation payment. Defines the temporal scope of the compensation obligation being fulfilled.',
    `payment_period_start_date` DATE COMMENT 'The start date of the period covered by this compensation payment. Used for periodic payments (e.g., monthly, quarterly, annual compensation).',
    `payment_reference_number` STRING COMMENT 'Externally visible unique reference number for this compensation payment, used for tracking and reconciliation purposes. May be shared with payees and auditors.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the compensation payment transaction. Tracks the payment from scheduling through completion or failure.. Valid values are `scheduled|processed|completed|failed|cancelled|reversed`',
    `payment_type` STRING COMMENT 'Categorizes the nature of the compensation payment within the agreement lifecycle. Distinguishes between initial, ongoing, final, and adjustment payments.. Valid values are `initial|periodic|final|adjustment|arrears|advance`',
    `project_code` STRING COMMENT 'The project or capital program code associated with this compensation payment. Links payment to specific mining projects or development initiatives.',
    `receipt_confirmation_date` DATE COMMENT 'The date on which the payee confirmed receipt of the compensation payment. Used to track payment completion and close the transaction lifecycle.',
    `receipt_confirmation_status` STRING COMMENT 'Indicates whether the payee has confirmed receipt of the compensation payment. Critical for audit trail and dispute resolution.. Valid values are `confirmed|pending|not_received|disputed`',
    `reconciliation_date` DATE COMMENT 'The date on which this compensation payment was reconciled in the financial system. Marks the completion of the financial control process.',
    `reconciliation_status` STRING COMMENT 'Indicates whether this payment has been reconciled against the general ledger and agreement obligations. Critical for financial audit and compliance.. Valid values are `reconciled|pending|discrepancy|under_review`',
    `reversal_reason` STRING COMMENT 'Explanation for why this compensation payment was reversed or cancelled after initial processing. Critical for audit trail and dispute resolution.',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the gross payment amount as required by local tax regulations. Represents statutory deductions before net disbursement.',
    CONSTRAINT pk_compensation_payment PRIMARY KEY(`compensation_payment_id`)
) COMMENT 'Transactional record of each compensation payment disbursed to landowners or community members under a land compensation agreement. Captures payment date, payee details, agreement reference, payment amount, currency, payment method, payment period covered, bank transfer reference, receipt confirmation, and reconciliation status. Provides the financial audit trail for community compensation obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`investment_program` (
    `investment_program_id` BIGINT COMMENT 'Unique identifier for the community investment program record. Primary key.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: Community investment programs are often funded or mandated under benefit-sharing agreements as part of the mining companys obligations to host communities. The investment_program.benefit_sharing_agre',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Community investment programs and benefit sharing funds are frequently tied to specific commodity extraction (e.g., iron ore community fund, lithium benefit program). Enables commodity-specific royalt',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Community investment programs are budgeted and tracked as cost centers in mining operations. Links program expenditure to financial cost allocation for AISC reporting and budget variance analysis.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Community investment programs post to specific GL accounts (CSR expenditure, community investment) for financial statement classification and external sustainability reporting.',
    `mine_site_id` BIGINT COMMENT 'Identifier of the mine site or mining operation funding and sponsoring this community investment program.',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Community investment programs contract vendors (construction firms, training providers, health services) to deliver program outcomes. The implementing_partner text field should be formalized as FK to ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Investment programs require a named employee as program manager for budget accountability, delivery oversight, stakeholder coordination, and outcome reporting. Enables performance tracking and workloa',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Community investment programs are designed for specific target communities who are stakeholders. Currently target_community is text. Normalizing to FK enables tracking investment programs per stakehol',
    `parent_investment_program_id` BIGINT COMMENT 'Self-referencing FK on investment_program (parent_investment_program_id)',
    `approval_date` DATE COMMENT 'Date when the community investment program received formal approval from the authorized decision-making body or executive committee.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive, committee, or authority that approved the community investment program.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this community investment program record was first created in the system.',
    `csr_strategy_alignment` STRING COMMENT 'Description of how this community investment program aligns with the mining operations broader Corporate Social Responsibility strategy, sustainability commitments, and social licence to operate objectives.',
    `end_date` DATE COMMENT 'Planned or actual date when the community investment program is scheduled to complete or was completed. Null for ongoing programs without defined end dates.',
    `environmental_impact_consideration` STRING COMMENT 'Description of environmental considerations, assessments, or mitigation measures incorporated into the design and delivery of the community investment program.',
    `estimated_beneficiaries` STRING COMMENT 'Estimated number of individuals or households expected to directly benefit from the community investment program.',
    `funding_source` STRING COMMENT 'Origin of funding for the community investment program: corporate CSR (Corporate Social Responsibility) budget, OPEX (Operating Expenditure), CAPEX (Capital Expenditure), joint venture contribution, government partnership, or third-party grant.. Valid values are `corporate_csr|opex|capex|joint_venture|government_partnership|third_party_grant`',
    `geographic_region` STRING COMMENT 'Broader geographic region or administrative area where the target community is located (e.g., district, province, state).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this community investment program record was last updated or modified.',
    `program_code` STRING COMMENT 'Unique business identifier code assigned to the community investment program for external reference and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_name` STRING COMMENT 'Full descriptive name of the community investment program as communicated to stakeholders and communities.',
    `program_objectives` STRING COMMENT 'Detailed description of the intended outcomes, goals, and measurable objectives that the community investment program aims to achieve.',
    `program_status` STRING COMMENT 'Current lifecycle status of the community investment program: draft (under development), approved (authorized but not started), active (currently being implemented), suspended (temporarily halted), completed (finished and closed), cancelled (terminated before completion).. Valid values are `draft|approved|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Category of community investment program indicating the primary focus area: education (schools, scholarships, training), health (clinics, medical services), infrastructure (roads, water, electricity), livelihood (employment, enterprise development), environment (conservation, rehabilitation), or cultural (heritage preservation, cultural activities).. Valid values are `education|health|infrastructure|livelihood|environment|cultural`',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress reports and performance updates for the community investment program are required to be submitted to stakeholders.. Valid values are `monthly|quarterly|semi_annually|annually|ad_hoc`',
    `risk_assessment` STRING COMMENT 'Summary of identified risks to program delivery, community acceptance, or intended outcomes, along with mitigation strategies.',
    `stakeholder_consultation_date` DATE COMMENT 'Date when formal consultation with affected communities and stakeholders was conducted prior to program approval and commencement.',
    `start_date` DATE COMMENT 'Planned or actual date when the community investment program commenced implementation activities.',
    `sustainability_indicator` STRING COMMENT 'Key performance indicator or metric used to measure the long-term sustainability and impact of the community investment program beyond the mining operations involvement.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the community investment program across its entire lifecycle, expressed in the operating currency.',
    CONSTRAINT pk_investment_program PRIMARY KEY(`investment_program_id`)
) COMMENT 'Master record of community investment and development programs funded by the mining operation as part of its social licence and benefit-sharing commitments. Captures program name, program type (education, health, infrastructure, livelihood, environment, cultural), target community or region, program objectives, total budget, funding source, implementing partner, start and end dates, approval status, and alignment to corporate social responsibility (CSR) strategy.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`investment_project` (
    `investment_project_id` BIGINT COMMENT 'Unique identifier for the community investment project. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Individual community projects charge costs to specific cost centers for financial tracking, budget control, and consolidation into site-level operational expenditure reporting.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Individual projects post to GL accounts for expense classification (operating vs capital, AISC inclusion) and financial statement preparation.',
    `investment_program_id` BIGINT COMMENT 'Reference to the parent community investment program under which this project is executed.',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Individual community investment projects engage vendors to deliver specific outcomes (build school, deliver training program). The implementing_organisation text field should be formalized as FK to ve',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Investment projects require a named employee as project officer for execution accountability, stakeholder coordination, milestone tracking, and benefit verification. Critical for workload management a',
    `site_id` BIGINT COMMENT 'Reference to the mining site or operational location associated with this community investment project.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Individual investment projects (under community investment programs) target specific beneficiary communities who are stakeholders. Currently target_beneficiary_community is text. Normalizing to FK ena',
    `parent_investment_project_id` BIGINT COMMENT 'Self-referencing FK on investment_project (parent_investment_project_id)',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred to date on the investment project in the reporting currency.',
    `alignment_with_sdg` STRING COMMENT 'United Nations Sustainable Development Goals that this investment project contributes to (e.g., SDG 1, SDG 4, SDG 8).',
    `approval_date` DATE COMMENT 'Date when the investment project was formally approved for execution.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount approved for the investment project in the reporting currency.',
    `approved_by` STRING COMMENT 'Name or role of the individual or committee that approved the investment project.',
    `beneficiary_count` STRING COMMENT 'Estimated or actual number of individuals or households directly benefiting from the investment project.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and expenditure amounts.. Valid values are `^[A-Z]{3}$`',
    `deliverables` STRING COMMENT 'Description of the tangible outputs and deliverables expected from the investment project.',
    `geographic_location` STRING COMMENT 'Geographic description or coordinates of the project location (village, district, region).',
    `milestone_status` STRING COMMENT 'Summary of key project milestones and their current completion status.',
    `outcome_indicators` STRING COMMENT 'Key performance indicators and metrics used to measure the social impact and success of the investment project.',
    `partnership_type` STRING COMMENT 'Type of partnership arrangement for project delivery (sole, joint venture, NGO partnership, government partnership, community-led).. Valid values are `sole|joint_venture|ngo_partnership|government_partnership|community_led`',
    `project_category` STRING COMMENT 'Classification of the investment project by type of community benefit (infrastructure, education, health, economic development, environmental, cultural, capacity building). [ENUM-REF-CANDIDATE: infrastructure|education|health|economic_development|environmental|cultural|capacity_building — 7 candidates stripped; promote to reference product]',
    `project_code` STRING COMMENT 'Unique business identifier or code assigned to the project for tracking and reporting purposes.',
    `project_completion_date` DATE COMMENT 'Planned or actual completion date of the investment project.',
    `project_scope` STRING COMMENT 'Detailed description of the project scope, objectives, and activities to be undertaken.',
    `project_start_date` DATE COMMENT 'Planned or actual start date of the investment project.',
    `project_status` STRING COMMENT 'Current lifecycle status of the investment project (planned, approved, in progress, on hold, completed, cancelled).. Valid values are `planned|approved|in_progress|on_hold|completed|cancelled`',
    `project_title` STRING COMMENT 'The official name or title of the community investment project.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this investment project record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this investment project record was last updated in the system.',
    `reporting_period` STRING COMMENT 'Financial or calendar period for which project progress and expenditure are reported.',
    `risk_assessment` STRING COMMENT 'Summary of key risks identified for the investment project and mitigation strategies.',
    `sustainability_plan` STRING COMMENT 'Description of the plan to ensure long-term sustainability and community ownership of project outcomes after completion.',
    CONSTRAINT pk_investment_project PRIMARY KEY(`investment_project_id`)
) COMMENT 'Individual community investment project executed under a community investment program. Captures project title, implementing organisation, target beneficiary community, project scope, deliverables, approved budget, actual expenditure, project start and completion dates, milestone status, project officer, and outcome indicators. Enables granular tracking of community investment spend and impact at the project level.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` (
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Unique identifier for the benefit sharing agreement record. Primary key.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Benefit sharing agreements are formal arrangements with specific stakeholder communities. Currently beneficiary is stored as text (beneficiary_community_name, beneficiary_community_type). Normalizing ',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Benefit sharing agreements commonly specify royalty percentages or payment triggers based on specific commodity production or revenue (e.g., "2% of iron ore FOB revenue"). Critical for calculating com',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Benefit sharing agreements require a named company employee as signatory and ongoing relationship manager for payment authorization, dispute resolution, and review coordination. Critical for audit tra',
    `land_compensation_agreement_id` BIGINT COMMENT 'Reference to a related land compensation agreement, if this benefit sharing agreement was negotiated in conjunction with land access arrangements.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mining operation or site that is the source of benefits under this agreement.',
    `ore_reserve_id` BIGINT COMMENT 'Foreign key linking to exploration.ore_reserve. Business justification: Ore reserves determine benefit sharing calculations (royalty percentages, payment triggers based on production). Agreement administration, payment scheduling, and periodic reviews require linking agre',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Benefit sharing agreements are tied to specific orebodies. Royalty calculations and benefit distributions are based on production from identified orebodies. Real business process: community benefit di',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Benefit sharing obligations are tracked at mine site (profit centre) level for segment reporting, life-of-mine cost forecasting, and AISC guidance calculation.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Benefit sharing agreements are tied to specific tenements for royalty calculation based on production from that tenement. Critical for financial distribution, royalty tracking, and community benefit a',
    `superseded_benefit_sharing_agreement_id` BIGINT COMMENT 'Self-referencing FK on benefit_sharing_agreement (superseded_benefit_sharing_agreement_id)',
    `agreement_code` STRING COMMENT 'Externally-known unique business identifier for the benefit sharing agreement, typically used in legal documents and reporting.. Valid values are `^BSA-[A-Z0-9]{6,12}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the benefit sharing agreement. [ENUM-REF-CANDIDATE: draft|under_negotiation|approved|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_title` STRING COMMENT 'Full legal title or name of the benefit sharing agreement as documented in the signed contract.',
    `agreement_type` STRING COMMENT 'Primary classification of the benefit sharing arrangement mechanism.. Valid values are `royalty_share|employment_quota|local_procurement|infrastructure_contribution|trust_fund|equity_participation`',
    `approval_date` DATE COMMENT 'Date on which the agreement was formally approved by company executive leadership or board.',
    `approved_by` STRING COMMENT 'Name or title of the executive or governance body that approved the agreement.',
    `benefit_calculation_methodology` STRING COMMENT 'Detailed description of the formula or methodology used to calculate benefit amounts, including base metrics (revenue, production volume, profit) and calculation frequency.',
    `community_representative_name` STRING COMMENT 'Name of the primary community representative or leader authorized to act on behalf of the beneficiary community.',
    `consultation_process_description` STRING COMMENT 'Summary of the consultation and negotiation process undertaken with the community, including dates and methods (town halls, focus groups, traditional decision-making processes).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit sharing agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement.. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_mechanism` STRING COMMENT 'Description of the agreed process for resolving disputes arising from the agreement (mediation, arbitration, traditional justice systems).',
    `effective_date` DATE COMMENT 'Date on which the benefit sharing agreement becomes legally binding and benefit obligations commence.',
    `employment_quota_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of workforce positions reserved for members of the beneficiary community, if applicable.',
    `estimated_beneficiaries_count` STRING COMMENT 'Estimated number of individuals or households in the beneficiary community expected to receive direct or indirect benefits.',
    `expiry_date` DATE COMMENT 'Date on which the benefit sharing agreement terminates or expires, if applicable. Null for agreements tied to Life of Mine (LOM).',
    `fpic_documentation_reference` STRING COMMENT 'Reference to the document or record that evidences the FPIC process and outcome.',
    `free_prior_informed_consent_obtained` BOOLEAN COMMENT 'Flag indicating whether Free, Prior and Informed Consent was obtained from indigenous or traditional communities as per international standards.',
    `geographic_region` STRING COMMENT 'Geographic area or administrative region where the beneficiary community is located.',
    `governance_structure` STRING COMMENT 'Description of the joint governance or oversight body established to administer the agreement, including representation from company and community.',
    `infrastructure_contribution_amount` DECIMAL(18,2) COMMENT 'Total monetary value committed for infrastructure development (roads, schools, clinics, water systems) for the beneficiary community.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit sharing agreement record was last updated in the system.',
    `legal_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal agreement document stored in the document management system.',
    `local_procurement_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of procurement spend to be directed to local suppliers from the beneficiary community, if applicable.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the agreement terms.',
    `payment_frequency` STRING COMMENT 'Frequency at which benefit payments are made to the beneficiary community.. Valid values are `monthly|quarterly|semi_annual|annual|milestone_based|one_time`',
    `payment_trigger` STRING COMMENT 'Event or schedule that triggers benefit payments or delivery under this agreement.. Valid values are `quarterly|annual|production_milestone|revenue_threshold|project_phase`',
    `reporting_frequency` STRING COMMENT 'Frequency at which the company must report benefit delivery performance to the community and governance body.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `review_schedule` STRING COMMENT 'Frequency at which the agreement terms are formally reviewed and potentially renegotiated by both parties.. Valid values are `annual|biennial|triennial|five_year|milestone_based`',
    `royalty_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of mining royalties or revenue to be shared with the beneficiary community, if applicable to this agreement type.',
    `social_licence_to_operate_indicator` BOOLEAN COMMENT 'Flag indicating whether this agreement is considered critical to maintaining the social licence to operate at the associated mine site.',
    `trust_fund_contribution_amount` DECIMAL(18,2) COMMENT 'Total monetary value committed to a community trust fund or endowment under this agreement.',
    CONSTRAINT pk_benefit_sharing_agreement PRIMARY KEY(`benefit_sharing_agreement_id`)
) COMMENT 'Master record of benefit-sharing arrangements between the mining company and host communities or indigenous groups, defining how economic benefits from mining operations are distributed. Captures agreement title, beneficiary community, benefit types (royalty share, employment quotas, local procurement targets, infrastructure contributions, trust fund contributions), benefit calculation methodology, payment triggers, governance structure, and review schedule. Distinct from land_compensation_agreement which covers direct land access payments.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`benefit_distribution` (
    `benefit_distribution_id` BIGINT COMMENT 'Unique identifier for the benefit distribution transaction. Primary key for the benefit distribution record.',
    `beneficiary_trust_fund_id` BIGINT COMMENT 'Reference to the trust fund or community foundation receiving this benefit distribution. Used when benefits are paid into a managed fund rather than directly to community representatives.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Reference to the parent benefit-sharing agreement under which this distribution is made. Links to the master agreement governing benefit-sharing obligations.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Benefit distributions are often calculated using commodity-specific formulas (e.g., "$2 per tonne of coal", "1.5% of copper revenue"). Essential for accurate benefit calculation, audit trail of commod',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Benefit distributions are posted to cost centers for financial accounting. Existing cost_centre_code is denormalized; FK enables proper cost allocation and AISC unit cost calculation.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site or operation from which this benefit distribution originates. Links the distribution to the specific mining operation generating the benefit obligation.',
    `performance_actual_id` BIGINT COMMENT 'Foreign key linking to sales.performance_actual. Business justification: Benefit-sharing payments in mining are calculated from actual sales revenue and production volumes. The calculation_period_revenue field on benefit_distribution directly corresponds to sales performan',
    `stakeholder_id` BIGINT COMMENT 'Reference to the community entity receiving this benefit distribution. Identifies the specific community, indigenous group, or local authority entitled to the benefit.',
    `prior_benefit_distribution_id` BIGINT COMMENT 'Self-referencing FK on benefit_distribution (prior_benefit_distribution_id)',
    `authorisation_date` DATE COMMENT 'Date on which the benefit distribution was formally authorised for disbursement. Precedes the actual distribution date.',
    `authorisation_reference` STRING COMMENT 'Reference to the internal approval or authorisation document that approved this distribution. Links to workflow approval ID or board resolution number.',
    `authorised_by` STRING COMMENT 'Name or identifier of the person or committee who authorised this benefit distribution. Provides accountability for distribution decisions.',
    `benefit_category` STRING COMMENT 'High-level categorization of the benefit for reporting and analytics. Groups benefit types into strategic categories aligned with social licence to operate objectives.. Valid values are `direct_payment|community_investment|capacity_building|infrastructure|compensation|other`',
    `benefit_type` STRING COMMENT 'Classification of the type of benefit being distributed. Distinguishes between monetary payments, in-kind contributions, and specific purpose funds. [ENUM-REF-CANDIDATE: royalty_payment|revenue_share|infrastructure_contribution|employment_fund|education_fund|health_fund|in_kind_service|land_compensation|other — 9 candidates stripped; promote to reference product]',
    `calculation_basis` STRING COMMENT 'Description of the formula or basis used to calculate the benefit amount (e.g., percentage of revenue, fixed annual amount, per-tonne royalty). Provides transparency for benefit calculation methodology.',
    `calculation_period_production_volume` DECIMAL(18,2) COMMENT 'Total production volume (in tonnes or other unit) for the reporting period used in benefit calculation. Applicable when benefit is calculated per unit of production.',
    `calculation_period_revenue` DECIMAL(18,2) COMMENT 'Total revenue for the reporting period used in benefit calculation. Applicable when benefit is calculated as a percentage of revenue. Confidential business data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit distribution record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value amount. Supports multi-currency benefit distributions across international operations.. Valid values are `^[A-Z]{3}$`',
    `dispute_raised` BOOLEAN COMMENT 'Indicates whether the beneficiary has raised a dispute or grievance regarding this distribution. True when formal dispute is logged.',
    `dispute_reference_number` STRING COMMENT 'Reference number of the grievance or dispute case related to this distribution. Links to the community grievance management system.',
    `distribution_date` DATE COMMENT 'The date on which the benefit was distributed or disbursed to the beneficiary community or trust fund. Principal business event timestamp for this transaction.',
    `distribution_method` STRING COMMENT 'The mechanism or channel through which the benefit was distributed to the beneficiary. Distinguishes between financial instruments and direct service delivery. [ENUM-REF-CANDIDATE: bank_transfer|cheque|cash|trust_fund_deposit|direct_service|infrastructure_delivery|other — 7 candidates stripped; promote to reference product]',
    `distribution_reference_number` STRING COMMENT 'Externally-known unique reference number for this benefit distribution event, used for audit trail and community reporting. Format: site code (3 letters), year (4 digits), sequence (6 digits).. Valid values are `^[A-Z]{3}-[0-9]{4}-[0-9]{6}$`',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the benefit distribution. Tracks progression from planning through to receipt confirmation or dispute resolution.. Valid values are `planned|approved|disbursed|confirmed|disputed|cancelled`',
    `general_ledger_account_code` STRING COMMENT 'General ledger account code for posting this benefit distribution expense. Links to the chart of accounts for financial consolidation.. Valid values are `^[0-9]{6,10}$`',
    `in_kind_description` STRING COMMENT 'Detailed description of in-kind benefits provided (e.g., infrastructure construction, equipment donation, training programs). Null for pure monetary distributions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit distribution record was last updated. Audit trail for data lineage and change tracking.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this record. Supports audit trail and accountability.',
    `monetary_value_amount` DECIMAL(18,2) COMMENT 'The monetary value of the benefit distribution. For cash payments, this is the disbursed amount. For in-kind benefits, this is the fair market value equivalent.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or clarifications related to this benefit distribution event.',
    `payment_reference_number` STRING COMMENT 'External payment system reference number for monetary distributions. Links to bank transfer, cheque number, or ERP payment document for reconciliation.',
    `production_volume_unit` STRING COMMENT 'Unit of measure for the calculation period production volume. Aligns with commodity-specific measurement standards.. Valid values are `tonnes|kilograms|ounces|pounds|cubic_metres|other`',
    `receipt_confirmation_date` DATE COMMENT 'Date on which the beneficiary formally acknowledged receipt of the benefit. Used to close the distribution audit trail.',
    `receipt_confirmation_received` BOOLEAN COMMENT 'Indicates whether formal receipt confirmation has been received from the beneficiary. True when signed acknowledgment or receipt document is on file.',
    `receipt_document_reference` STRING COMMENT 'Reference to the stored receipt document, signed acknowledgment, or confirmation letter. Points to document management system location.',
    `reporting_period_end_date` DATE COMMENT 'End date of the reporting period to which this benefit distribution applies. Defines the temporal scope of the benefit calculation.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the reporting period to which this benefit distribution applies. Used for periodic benefit-sharing calculations and compliance reporting.',
    CONSTRAINT pk_benefit_distribution PRIMARY KEY(`benefit_distribution_id`)
) COMMENT 'Transactional record of each benefit distribution event made to communities under a benefit-sharing agreement. Captures distribution date, beneficiary community or trust fund, benefit type, monetary value or in-kind equivalent, distribution method, authorisation reference, receipt confirmation, and reporting period. Provides the audit trail for benefit-sharing compliance and community reporting obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`social_licence_indicator` (
    `social_licence_indicator_id` BIGINT COMMENT 'Unique identifier for the social licence to operate indicator measurement record.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site or operational area where this social licence indicator was measured.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Social licence monitoring requires a named employee as accountable manager for action planning, escalation, and executive reporting. Enables performance tracking and ensures accountability for social ',
    `prior_social_licence_indicator_id` BIGINT COMMENT 'Self-referencing FK on social_licence_indicator (prior_social_licence_indicator_id)',
    `action_required` BOOLEAN COMMENT 'Indicates whether immediate action or intervention is required based on this social licence indicator measurement.',
    `affected_communities` STRING COMMENT 'The names or identifiers of the communities included in this social licence indicator measurement.',
    `assessor_name` STRING COMMENT 'The name of the individual or lead assessor who conducted or coordinated this social licence indicator measurement.',
    `assessor_organisation` STRING COMMENT 'The name of the organisation that conducted the assessment, particularly relevant for third-party assessments.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'The statistical confidence level associated with this measurement, indicating the reliability of the results.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this social licence indicator record was first created in the system.',
    `document_location` STRING COMMENT 'The file path, URL, or storage location of the detailed report or supporting documentation for this social licence indicator measurement.',
    `indicator_category` STRING COMMENT 'The category of the indicator, classifying whether it measures perception, behaviour, outcome, or impact.. Valid values are `perception|behaviour|outcome|impact`',
    `indicator_type` STRING COMMENT 'The type of social licence to operate indicator being measured, such as trust level, acceptance level, approval level, grievance rate, engagement participation rate, or community sentiment.. Valid values are `trust_level|acceptance_level|approval_level|grievance_rate|engagement_participation_rate|community_sentiment`',
    `indigenous_peoples_included` BOOLEAN COMMENT 'Indicates whether indigenous peoples were included in this social licence indicator measurement.',
    `key_findings_summary` STRING COMMENT 'A summary of the key findings from this social licence indicator measurement, highlighting significant insights or concerns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this social licence indicator record was last modified or updated in the system.',
    `margin_of_error_percent` DECIMAL(18,2) COMMENT 'The margin of error associated with this measurement, indicating the range of uncertainty in the results.',
    `measurement_date` DATE COMMENT 'The specific date when the measurement or assessment was conducted.',
    `measurement_frequency` STRING COMMENT 'The frequency at which this social licence indicator is measured, such as monthly, quarterly, semi-annually, annually, or ad-hoc.. Valid values are `monthly|quarterly|semi_annually|annually|ad_hoc`',
    `measurement_method` STRING COMMENT 'The method used to measure this social licence indicator, such as survey, focus group, third-party assessment, community meeting, stakeholder interview, or media analysis.. Valid values are `survey|focus_group|third_party_assessment|community_meeting|stakeholder_interview|media_analysis`',
    `measurement_period_end_date` DATE COMMENT 'The end date of the period during which this social licence indicator was measured.',
    `measurement_period_start_date` DATE COMMENT 'The start date of the period during which this social licence indicator was measured.',
    `next_measurement_due_date` DATE COMMENT 'The scheduled date for the next measurement of this social licence indicator.',
    `previous_period_score` DECIMAL(18,2) COMMENT 'The score from the previous measurement period for comparison and trend analysis.',
    `rating` STRING COMMENT 'The qualitative rating assigned to this social licence indicator based on the score, such as excellent, good, fair, poor, or critical.. Valid values are `excellent|good|fair|poor|critical`',
    `recommended_actions` STRING COMMENT 'The recommended actions or interventions to address issues identified in this social licence indicator measurement.',
    `report_reference_number` STRING COMMENT 'The reference number or identifier of the detailed report or documentation associated with this social licence indicator measurement.',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of invited participants who responded or participated in the measurement activity.',
    `risk_level` STRING COMMENT 'The assessed risk level to the social licence to operate based on this indicator measurement, categorized as low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'The number of respondents, participants, or data points included in the measurement of this indicator.',
    `score` DECIMAL(18,2) COMMENT 'The numerical score or rating assigned to this social licence indicator, typically on a standardized scale (e.g., 0-100 or 1-5).',
    `score_scale_maximum` DECIMAL(18,2) COMMENT 'The maximum value of the scale used for this indicator score.',
    `score_scale_minimum` DECIMAL(18,2) COMMENT 'The minimum value of the scale used for this indicator score.',
    `stakeholder_groups_included` STRING COMMENT 'The stakeholder groups that participated in or were assessed as part of this measurement, such as indigenous peoples, local residents, business owners, or NGOs.',
    `target_score` DECIMAL(18,2) COMMENT 'The target or desired score for this social licence indicator as defined by the community relations strategy.',
    `third_party_verified` BOOLEAN COMMENT 'Indicates whether this social licence indicator measurement was verified or validated by an independent third party.',
    `trend_direction` STRING COMMENT 'The direction of the trend for this indicator compared to previous measurement periods, indicating whether the social licence is improving, stable, or declining.. Valid values are `improving|stable|declining|not_applicable`',
    `variance_from_previous_period` DECIMAL(18,2) COMMENT 'The numerical variance between the current score and the previous period score, indicating the magnitude of change.',
    `variance_from_target` DECIMAL(18,2) COMMENT 'The numerical variance between the current score and the target score, indicating performance against objectives.',
    CONSTRAINT pk_social_licence_indicator PRIMARY KEY(`social_licence_indicator_id`)
) COMMENT 'Periodic measurement record of social licence to operate (SLO) indicators and community sentiment metrics for each mine site or operational area. Captures measurement period, site, indicator type (trust level, acceptance level, approval level, grievance rate, engagement participation rate), measurement method (survey, focus group, third-party assessment), score or rating, trend direction, and responsible community relations manager. Enables tracking of SLO health over time.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`resettlement_plan` (
    `resettlement_plan_id` BIGINT COMMENT 'Unique identifier for the resettlement plan record. Primary key.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Resettlement plans affect specific communities who are critical stakeholders. Currently affected_community_name is text. Normalizing to FK ensures affected communities are registered stakeholders, ena',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Post-resettlement monitoring and livelihood restoration costs are operational expenditure charged to community relations cost centers for ongoing budget management.',
    `land_compensation_agreement_id` BIGINT COMMENT 'Foreign key linking to community.land_compensation_agreement. Business justification: Resettlement plans involve land acquisition and compensation to affected households. While not all resettlement plans may have a single overarching land compensation agreement (compensation may be han',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When resettlement planning is led by internal staff (common for smaller plans or monitoring phases), tracking the lead consultant ensures accountability, competency verification, and IFC PS5 complianc',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site or project that necessitates this resettlement plan due to land acquisition requirements.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Resettlement plans are triggered by specific orebody development. The plan scope and affected area are defined by the orebody footprint and mining method. Real business process: resettlement planning ',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Resettlement plans require specialized consulting firms (social impact specialists, resettlement experts) contracted as vendors. The lead_consultant_name text field should be formalized as FK to vendo',
    `social_impact_assessment_id` BIGINT COMMENT 'Reference to the parent social impact assessment that identified the need for this resettlement plan.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Resettlement plans are triggered by land acquisition for specific tenements. Essential for tracking IFC PS5 compliance, compensation obligations, and land acquisition tied to mining licence boundaries',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Resettlement costs are capitalized to project WBS as pre-production capital under IFC PS5 and IFRS. Links plan to capital project budget for cost tracking and regulatory reporting.',
    `superseded_resettlement_plan_id` BIGINT COMMENT 'Self-referencing FK on resettlement_plan (superseded_resettlement_plan_id)',
    `affected_households_count` STRING COMMENT 'Total number of households requiring resettlement or economic displacement compensation under this plan.',
    `affected_persons_count` STRING COMMENT 'Total number of individuals (persons) impacted by the resettlement plan, including all household members.',
    `approval_authority_name` STRING COMMENT 'Name of the government department, ministry, or agency responsible for approving the resettlement plan.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for compensation budget and payments.. Valid values are `^[A-Z]{3}$`',
    `compensation_framework` STRING COMMENT 'Description of the compensation methodology, including valuation approach, entitlement matrix, and payment mechanisms for land, assets, and livelihoods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this resettlement plan record was first created in the system.',
    `fpic_required_flag` BOOLEAN COMMENT 'Indicates whether Free Prior and Informed Consent is required from indigenous peoples affected by the resettlement plan.',
    `fpic_status` STRING COMMENT 'Current status of the FPIC process with indigenous peoples, if applicable.. Valid values are `not required|consultation in progress|consent obtained|consent withheld`',
    `grievance_mechanism_reference` STRING COMMENT 'Reference to the grievance mechanism established for affected persons to raise complaints and seek redress related to resettlement.',
    `ifc_ps5_compliance_status` STRING COMMENT 'Assessment of whether the resettlement plan meets IFC Performance Standard 5 requirements for land acquisition and involuntary resettlement, critical for project financing.. Valid values are `compliant|non-compliant|under assessment|not applicable`',
    `implementation_completion_date` DATE COMMENT 'Planned or actual date when all resettlement activities, including livelihood restoration and monitoring, are completed.',
    `implementation_start_date` DATE COMMENT 'Planned or actual date when resettlement plan implementation activities commenced.',
    `indigenous_peoples_affected_flag` BOOLEAN COMMENT 'Indicates whether indigenous peoples or ethnic minorities are among the affected population, triggering additional consultation and consent requirements.',
    `land_area_acquired_hectares` DECIMAL(18,2) COMMENT 'Total land area in hectares acquired from affected communities for mining operations, triggering this resettlement plan.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this resettlement plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this resettlement plan record was last updated.',
    `livelihood_restoration_strategy` STRING COMMENT 'Summary of the strategy to restore or improve livelihoods and income levels of displaced persons, including training, employment, and business support programs.',
    `monitoring_frequency` STRING COMMENT 'Frequency of monitoring and reporting on resettlement plan implementation progress and livelihood restoration outcomes.. Valid values are `monthly|quarterly|semi-annually|annually`',
    `next_monitoring_date` DATE COMMENT 'Scheduled date for the next monitoring assessment of resettlement plan implementation and outcomes.',
    `plan_document_location` STRING COMMENT 'File path or document management system reference to the full resettlement plan document and supporting annexes.',
    `plan_reference_number` STRING COMMENT 'Externally-known unique business identifier for the resettlement plan, used in regulatory submissions and stakeholder communications.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the resettlement plan in the regulatory approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|under consultation|submitted for approval|approved|implementation in progress|completed|closed — 7 candidates stripped; promote to reference product]',
    `plan_title` STRING COMMENT 'Formal title of the resettlement plan as registered with regulatory authorities and disclosed to affected communities.',
    `regulatory_approval_date` DATE COMMENT 'Date when the resettlement plan received formal approval from the government regulatory authority.',
    `regulatory_approval_status` STRING COMMENT 'Current status of the resettlement plan in the government regulatory approval process.. Valid values are `pending|under review|approved|conditionally approved|rejected|resubmission required`',
    `regulatory_submission_date` DATE COMMENT 'Date when the resettlement plan was formally submitted to the relevant government authority for review and approval.',
    `resettlement_site_coordinates` STRING COMMENT 'Geographic coordinates (latitude, longitude) of the resettlement site for GIS mapping and monitoring.',
    `resettlement_site_location` STRING COMMENT 'Geographic location description of the resettlement site, including district, region, and proximity to services.',
    `resettlement_site_name` STRING COMMENT 'Name or designation of the new site where physical relocation will occur. Null for economic displacement only.',
    `resettlement_type` STRING COMMENT 'Classification of resettlement impact: physical relocation (households must move), economic displacement (loss of livelihood without relocation), or combined.. Valid values are `physical relocation|economic displacement|combined physical and economic`',
    `stakeholder_consultation_date` DATE COMMENT 'Date of the most recent formal consultation meeting with affected communities regarding the resettlement plan.',
    `total_compensation_budget_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount allocated for all compensation payments, livelihood restoration, and resettlement implementation costs.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this resettlement plan record.',
    CONSTRAINT pk_resettlement_plan PRIMARY KEY(`resettlement_plan_id`)
) COMMENT 'Master record of physical and economic resettlement plans required when mining operations necessitate the relocation of communities or households. Captures plan title, affected community, number of households affected, resettlement type (physical relocation, economic displacement), resettlement site details, livelihood restoration strategy, compensation framework, implementation timeline, regulatory approval status, and IFC PS5 compliance status. Critical for large-scale mining projects with land acquisition requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`resettlement_household` (
    `resettlement_household_id` BIGINT COMMENT 'Unique identifier for the resettlement household record. Primary key for tracking individual households through the resettlement lifecycle.',
    `land_parcel_id` BIGINT COMMENT 'Cadastral or land registry identifier for the households original land parcel.',
    `resettlement_plan_id` BIGINT COMMENT 'Reference to the overarching resettlement program under which this household is being resettled.',
    `split_from_resettlement_household_id` BIGINT COMMENT 'Self-referencing FK on resettlement_household (split_from_resettlement_household_id)',
    `allocated_land_area_hectares` DECIMAL(18,2) COMMENT 'Total area of replacement land allocated to the household at the resettlement site, measured in hectares.',
    `allocated_plot_number` STRING COMMENT 'Unique plot or housing unit number allocated to the household at the resettlement site.',
    `asset_inventory_value` DECIMAL(18,2) COMMENT 'Total assessed value of household assets including crops, trees, improvements, and other fixed assets subject to compensation.',
    `baseline_annual_income` DECIMAL(18,2) COMMENT 'Estimated total annual household income at baseline prior to resettlement, used for livelihood restoration monitoring.',
    `cash_compensation_amount` DECIMAL(18,2) COMMENT 'Total cash compensation amount payable to the household for land, structures, and assets.',
    `census_date` DATE COMMENT 'Date on which the household census and asset inventory were conducted, establishing the cut-off date for entitlement eligibility.',
    `compensation_payment_date` DATE COMMENT 'Date on which final cash compensation was paid to the household.',
    `compensation_payment_status` STRING COMMENT 'Status of cash compensation payments to the household.. Valid values are `pending|partial|completed|disputed|withheld`',
    `contact_phone_number` STRING COMMENT 'Primary phone number for contacting the household head for monitoring, assistance, and communication purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was first created in the resettlement management system.',
    `eligibility_status` STRING COMMENT 'Current status of the households eligibility for resettlement entitlements based on census and verification processes.. Valid values are `eligible|ineligible|pending_verification|disputed`',
    `entitlement_category` STRING COMMENT 'Primary category of resettlement entitlement package offered to the household based on impact and preference.. Valid values are `land_for_land|cash_compensation|replacement_housing|livelihood_support|combination`',
    `grievance_lodged_flag` BOOLEAN COMMENT 'Indicates whether the household has lodged any grievance related to the resettlement process or entitlements.',
    `grievance_resolution_status` STRING COMMENT 'Current status of any grievances lodged by the household through the grievance redress mechanism.. Valid values are `no_grievance|open|under_review|resolved|escalated`',
    `household_head_name` STRING COMMENT 'Full legal name of the head of household as recorded in the census and used for entitlement registration.',
    `household_head_national_identifier` STRING COMMENT 'Government-issued national identification number of the household head for legal verification and entitlement processing.',
    `household_reference_number` STRING COMMENT 'Externally-known unique reference code assigned to the household for tracking and communication purposes throughout the resettlement process.. Valid values are `^[A-Z0-9]{6,20}$`',
    `household_size` STRING COMMENT 'Total number of individuals residing in the household at the time of census enumeration.',
    `income_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for baseline income and compensation amounts.. Valid values are `^[A-Z]{3}$`',
    `indigenous_household_flag` BOOLEAN COMMENT 'Indicates whether the household is identified as indigenous or belonging to a traditional community requiring culturally appropriate resettlement measures.',
    `land_area_hectares` DECIMAL(18,2) COMMENT 'Total area of land held or occupied by the household at the original location, measured in hectares.',
    `land_tenure_type` STRING COMMENT 'Type of land tenure or occupancy right held by the household at the original location, determining entitlement eligibility.. Valid values are `legal_owner|customary_owner|tenant|squatter|sharecropper|communal`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the household record was last updated, tracking changes throughout the resettlement lifecycle.',
    `last_monitoring_date` DATE COMMENT 'Date of the most recent post-resettlement monitoring visit or survey conducted with the household.',
    `livelihood_restoration_plan_status` STRING COMMENT 'Status of livelihood restoration activities and support measures for the household.. Valid values are `not_started|in_progress|completed|not_required`',
    `monitoring_phase` STRING COMMENT 'Current phase of post-resettlement monitoring for tracking household outcomes and livelihood restoration progress.. Valid values are `baseline|transition|post_relocation_year_1|post_relocation_year_2|post_relocation_year_3|completed`',
    `original_address` STRING COMMENT 'Full address of the households original residence prior to resettlement, used for asset verification and entitlement calculation.',
    `original_village_name` STRING COMMENT 'Name of the village or settlement from which the household is being displaced.',
    `primary_livelihood_source` STRING COMMENT 'Main source of household income or livelihood at baseline, used for livelihood restoration planning. [ENUM-REF-CANDIDATE: agriculture|livestock|fishing|mining|trade|wage_employment|artisan|other — 8 candidates stripped; promote to reference product]',
    `relocation_date` DATE COMMENT 'Actual date on which the household physically relocated from the original location to the resettlement site.',
    `relocation_status` STRING COMMENT 'Current status of the households physical relocation process.. Valid values are `not_started|in_progress|completed|refused|deferred`',
    `resettlement_site_name` STRING COMMENT 'Name of the resettlement site or host community where the household has been allocated a plot or housing unit.',
    `structure_replacement_value` DECIMAL(18,2) COMMENT 'Assessed replacement cost of the households dwelling structure at full replacement value without depreciation.',
    `structure_type` STRING COMMENT 'Classification of the households dwelling structure at the original location, used for replacement cost calculation.. Valid values are `permanent|semi_permanent|temporary|traditional`',
    `total_entitlement_value` DECIMAL(18,2) COMMENT 'Total calculated value of all resettlement entitlements due to the household including compensation, assistance, and support measures.',
    `vulnerability_category` STRING COMMENT 'Primary category of vulnerability for households requiring additional assistance or enhanced entitlements.. Valid values are `female_headed|elderly|disabled|child_headed|extreme_poverty|multiple_vulnerabilities`',
    `vulnerable_household_flag` BOOLEAN COMMENT 'Indicates whether the household is classified as vulnerable based on criteria such as female-headed, elderly, disabled members, or extreme poverty.',
    CONSTRAINT pk_resettlement_household PRIMARY KEY(`resettlement_household_id`)
) COMMENT 'Master record of each household affected by a resettlement program, capturing household census data, asset inventory, livelihood baseline, entitlement calculation, resettlement site allocation, relocation date, and post-resettlement monitoring status. Enables household-level tracking of resettlement entitlements and outcomes to demonstrate compliance with IFC Performance Standard 5 and Equator Principles.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`local_employment_commitment` (
    `local_employment_commitment_id` BIGINT COMMENT 'Unique identifier for the local employment commitment record. Primary key.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: Local employment commitments are often formalized within benefit-sharing agreements. The local_employment_commitment.benefit_sharing_agreement_reference string attribute should be normalized to a prop',
    `capital_project_id` BIGINT COMMENT 'Identifier of the capital project or expansion associated with this commitment, if applicable.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Employment commitments are tracked at cost center level for workforce planning, labor cost allocation, and local content compliance reporting.',
    `mine_site_id` BIGINT COMMENT 'Identifier of the mine site or operation to which this commitment applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Employment commitments require a named employee as accountable manager for target achievement, variance explanation, and regulatory reporting. Enables performance tracking and coordination with workfo',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Local employment commitments are made to specific communities who are stakeholders. Currently target_community is text. Normalizing to FK enables tracking commitments per stakeholder, supports perform',
    `superseded_local_employment_commitment_id` BIGINT COMMENT 'Self-referencing FK on local_employment_commitment (superseded_local_employment_commitment_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'Most recent actual performance figure against the commitment target.',
    `approval_date` DATE COMMENT 'Date on which the commitment was formally approved by management or board.',
    `approved_by` STRING COMMENT 'Name or title of the executive or authority who approved the commitment.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Starting or baseline figure for the commitment metric at the time the commitment was made (e.g., current local employment percentage).',
    `commitment_description` STRING COMMENT 'Detailed narrative description of the employment or procurement commitment, including scope and intent.',
    `commitment_effective_date` DATE COMMENT 'Date from which the commitment becomes binding and performance tracking begins.',
    `commitment_expiry_date` DATE COMMENT 'Date on which the commitment period ends or the commitment is fulfilled, nullable for ongoing commitments.',
    `commitment_reference` STRING COMMENT 'External business reference number or code for the commitment, used in agreements and reporting.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the commitment.. Valid values are `draft|active|suspended|achieved|not_met|closed`',
    `commitment_type` STRING COMMENT 'Category of local employment or procurement commitment made to the community.. Valid values are `employment_percentage|apprenticeship_quota|local_supplier_spend|training_program|graduate_program|indigenous_employment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commitment record was first created in the system.',
    `document_reference` STRING COMMENT 'Reference or URI to the source agreement, permit condition, or policy document containing the commitment.',
    `fpic_required_flag` BOOLEAN COMMENT 'Indicates whether Free Prior and Informed Consent was required for this commitment under indigenous rights frameworks.',
    `fpic_status` STRING COMMENT 'Status of Free Prior and Informed Consent process for this commitment.. Valid values are `not_required|pending|obtained|not_obtained`',
    `geographic_region` STRING COMMENT 'Geographic region, district, or local government area covered by the commitment.',
    `indigenous_peoples_flag` BOOLEAN COMMENT 'Indicates whether the commitment specifically targets indigenous or traditional owner communities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commitment record was last updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of commitment performance and status.',
    `measurement_period_end_date` DATE COMMENT 'End date of the period over which the commitment is measured and reported.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the period over which the commitment is measured and reported.',
    `mitigation_actions` STRING COMMENT 'Description of actions being taken to address underperformance or barriers to meeting the commitment.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of commitment performance.',
    `notes` STRING COMMENT 'Additional notes, context, or commentary regarding the commitment and its performance.',
    `performance_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual and target values, calculated as ((actual - target) / target) * 100.',
    `regulatory_condition_flag` BOOLEAN COMMENT 'Indicates whether the commitment is a regulatory or permit condition (true) or a voluntary commitment (false).',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress against the commitment must be reported to stakeholders or regulators.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `reporting_obligation` STRING COMMENT 'Description of the reporting obligation, including recipient (community, regulator, board) and format.',
    `responsible_department` STRING COMMENT 'Department or business unit responsible for implementing and tracking the commitment.',
    `social_licence_risk_level` STRING COMMENT 'Risk level to social licence if the commitment is not met, assessed by community relations team.. Valid values are `low|medium|high|critical`',
    `stakeholder_consultation_date` DATE COMMENT 'Date of the most recent consultation with the target community regarding this commitment.',
    `target_value` DECIMAL(18,2) COMMENT 'Target figure or goal for the commitment metric (e.g., 70% local employment, 50 apprenticeships).',
    `unit_of_measure` STRING COMMENT 'Unit in which the baseline, target, and actual values are expressed.. Valid values are `percentage|headcount|currency|hours`',
    CONSTRAINT pk_local_employment_commitment PRIMARY KEY(`local_employment_commitment_id`)
) COMMENT 'Master record of local employment and local procurement commitments made to host communities as part of social licence, benefit-sharing, or regulatory conditions. Captures commitment description, target community or region, commitment type (employment percentage, apprenticeship quota, local supplier spend target), baseline figure, target figure, measurement period, responsible manager, and reporting obligation. Distinct from workforce domain employee records; this entity tracks the commitment and its performance targets.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`local_content_actual` (
    `local_content_actual_id` BIGINT COMMENT 'Unique identifier for the local content actual performance record.',
    `commitment_id` BIGINT COMMENT 'Reference to the local content commitment or agreement that this actual performance is measured against.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Local content reporting requires a named employee as accountable manager for data accuracy, verification, and regulatory submission. Critical for audit trail and coordination with procurement and HR r',
    `site_id` BIGINT COMMENT 'Reference to the mine site where the local content performance was measured.',
    `revised_local_content_actual_id` BIGINT COMMENT 'Self-referencing FK on local_content_actual (revised_local_content_actual_id)',
    `actual_local_employment_headcount` STRING COMMENT 'The actual number of local employees employed during the reporting period.',
    `actual_local_supplier_spend_amount` DECIMAL(18,2) COMMENT 'The actual amount spent on local suppliers during the reporting period.',
    `compliance_status` STRING COMMENT 'The compliance status of the local content performance against the commitment or regulatory requirement.. Valid values are `compliant|non-compliant|partial|under-review|exempt`',
    `corrective_action_plan_reference` STRING COMMENT 'Reference to the corrective action plan document or record addressing local content performance gaps.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required to address non-compliance or underperformance against local content commitments.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this local content actual performance record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or process from which the actual local content performance data was extracted (e.g., SAP HR, Pronto Xi Procurement, manual survey).',
    `employment_variance_headcount` STRING COMMENT 'The variance between actual and target local employment headcount (actual minus target).',
    `employment_variance_percentage` DECIMAL(18,2) COMMENT 'The variance between actual and target local employment percentage (actual minus target).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this local content actual performance record was last modified or updated.',
    `local_employment_percentage_achieved` DECIMAL(18,2) COMMENT 'The percentage of local employment achieved relative to total workforce during the reporting period.',
    `local_spend_percentage_achieved` DECIMAL(18,2) COMMENT 'The percentage of local supplier spend achieved relative to total procurement spend during the reporting period.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the local content performance record, including context, exceptions, or special circumstances.',
    `regulatory_submission_reference` STRING COMMENT 'The reference number or identifier of the regulatory submission in which this local content performance data was reported.',
    `reporting_frequency` STRING COMMENT 'The frequency at which local content performance is reported to regulators and communities.. Valid values are `monthly|quarterly|semi-annual|annual`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the reporting period for which local content performance is measured.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the reporting period for which local content performance is measured.',
    `spend_variance_amount` DECIMAL(18,2) COMMENT 'The variance between actual and target local supplier spend amount (actual minus target).',
    `spend_variance_percentage` DECIMAL(18,2) COMMENT 'The variance between actual and target local spend percentage (actual minus target).',
    `submission_date` DATE COMMENT 'The date on which the local content performance report was submitted to the regulator or community stakeholders.',
    `submitted_by` STRING COMMENT 'The name of the individual or department that submitted the local content performance report.',
    `target_local_employment_headcount` STRING COMMENT 'The target number of local employees as per the commitment or agreement.',
    `target_local_employment_percentage` DECIMAL(18,2) COMMENT 'The target percentage of local employment as per the commitment or agreement.',
    `target_local_spend_percentage` DECIMAL(18,2) COMMENT 'The target percentage of local supplier spend as per the commitment or agreement.',
    `target_local_supplier_spend_amount` DECIMAL(18,2) COMMENT 'The target amount to be spent on local suppliers as per the commitment or agreement.',
    `total_procurement_spend_amount` DECIMAL(18,2) COMMENT 'The total procurement spend during the reporting period, used as the denominator for local spend percentage calculations.',
    `total_workforce_headcount` STRING COMMENT 'The total workforce headcount during the reporting period, used as the denominator for local employment percentage calculations.',
    `variance_explanation` STRING COMMENT 'A detailed explanation of any significant variance between actual and target local content performance, including root causes and corrective actions.',
    `verification_date` DATE COMMENT 'The date on which the local content performance data was verified or audited.',
    `verification_method` STRING COMMENT 'The method used to verify the accuracy of the reported local content performance data.. Valid values are `internal-audit|external-audit|self-reported|third-party-verified|regulatory-inspection`',
    `verified_by` STRING COMMENT 'The name of the individual or organization that verified the local content performance data.',
    CONSTRAINT pk_local_content_actual PRIMARY KEY(`local_content_actual_id`)
) COMMENT 'Periodic transactional record of actual local employment and local procurement performance measured against local content commitments. Captures reporting period, commitment reference, actual local employment headcount, local employment percentage achieved, local supplier spend amount, local spend percentage achieved, data source, and variance against target. Enables compliance reporting on local content obligations to regulators and communities.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`cultural_heritage_site` (
    `cultural_heritage_site_id` BIGINT COMMENT 'Unique identifier for the cultural heritage site record. Primary key for the cultural heritage site master register.',
    `mine_site_id` BIGINT COMMENT 'Identifier of the mine site or operational area associated with this heritage site. Used to assign heritage management responsibilities to site-level teams.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Cultural heritage sites within or near prospects require management during exploration. Drill pad siting, access road design, and FPIC consultation depend on this spatial relationship. Real business p',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Heritage sites require a named employee as custodian for access control, inspection scheduling, incident response, and traditional owner coordination. Enables accountability and succession planning fo',
    `tenement_id` BIGINT COMMENT 'Identifier of the mining tenement or lease within which or adjacent to which this heritage site is located. Links to the tenement register for spatial planning and clearance tracking.',
    `parent_cultural_heritage_site_id` BIGINT COMMENT 'Self-referencing FK on cultural_heritage_site (parent_cultural_heritage_site_id)',
    `access_protocol` STRING COMMENT 'Cultural protocols or procedures that must be followed when accessing or working near the heritage site. May include requirements for traditional owner accompaniment, gender restrictions, or ceremonial permissions.',
    `confidentiality_level` STRING COMMENT 'Data classification level for heritage site information based on cultural sensitivity and traditional owner preferences. Determines who may access detailed site information and coordinates.. Valid values are `public|internal|confidential|restricted`',
    `coordinate_accuracy_meters` DECIMAL(18,2) COMMENT 'The estimated accuracy of the GPS coordinates in meters. Indicates the precision of the site location for buffer zone calculations and spatial planning.',
    `coordinate_datum` STRING COMMENT 'The geodetic datum used for the GPS coordinates, typically WGS84 or local survey datum. Required for accurate spatial integration with mine planning systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this heritage site record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `cultural_group_affiliation` STRING COMMENT 'The Indigenous or traditional cultural group(s) to whom this heritage site holds cultural significance. May include multiple groups with shared or overlapping cultural connections. Confidential to respect cultural sensitivities.',
    `discovery_date` DATE COMMENT 'Date when the heritage site was first identified or discovered during exploration, survey, or mining activities. Tracks when the site entered the heritage register.',
    `document_location` STRING COMMENT 'File path, document management system reference, or URL where detailed heritage survey reports, site photographs, and assessment documentation are stored. Enables retrieval of supporting evidence.',
    `fpic_date` DATE COMMENT 'Date when Free Prior and Informed Consent was obtained from the affiliated cultural group. Documents the timing of consent for audit and compliance purposes.',
    `fpic_obtained_flag` BOOLEAN COMMENT 'Indicates whether Free Prior and Informed Consent has been obtained from the affiliated cultural group for any activities that may affect this heritage site. Critical for social licence to operate compliance.',
    `heritage_agreement_reference` STRING COMMENT 'Reference to any heritage protection agreement, cultural heritage management plan, or memorandum of understanding with traditional owners that governs management of this site.',
    `heritage_survey_reference` STRING COMMENT 'Reference number or identifier of the heritage survey, archaeological assessment, or ethnographic study that identified and documented this site. Links to survey reports and assessment documentation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or monitoring visit to the heritage site. Used to schedule periodic monitoring and ensure ongoing protection compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this heritage site record was most recently updated. Tracks data currency and change history for audit and compliance purposes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the heritage site location in decimal degrees. Confidential to prevent unauthorized access or disturbance to culturally sensitive sites.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the heritage site location in decimal degrees. Confidential to prevent unauthorized access or disturbance to culturally sensitive sites.',
    `management_restrictions` STRING COMMENT 'Specific management requirements, access restrictions, or operational constraints that must be observed to protect the heritage site. May include seasonal access restrictions, cultural protocols, or activity prohibitions.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next heritage site inspection or monitoring visit. Ensures regular monitoring frequency is maintained per heritage management plan commitments.',
    `no_go_zone_radius_meters` DECIMAL(18,2) COMMENT 'The buffer distance in meters around the heritage site within which mining activities, ground disturbance, or access is prohibited. Used to create exclusion zones in mine planning systems.',
    `notes` STRING COMMENT 'Additional notes, observations, or contextual information about the heritage site that does not fit structured fields. May include historical context, management challenges, or stakeholder feedback.',
    `protection_status` STRING COMMENT 'The legal or regulatory protection status assigned to the heritage site by government heritage authorities or through agreement with traditional owners. Determines access restrictions and mining exclusion zones.. Valid values are `statutory protected|registered|no-go zone|conditional access|under review|unprotected`',
    `registration_date` DATE COMMENT 'Date when the heritage site was formally registered in the company heritage management system or with statutory heritage authorities. Marks the start of formal protection obligations.',
    `regulatory_listing_reference` STRING COMMENT 'Reference number or identifier if the site is listed on a statutory heritage register maintained by government heritage authorities. Links to official heritage protection instruments.',
    `significance_description` STRING COMMENT 'Detailed description of the cultural, spiritual, historical, or archaeological significance of the site. Explains why the site is important to the affiliated cultural group and what values it embodies. Confidential to protect sacred knowledge.',
    `site_area_hectares` DECIMAL(18,2) COMMENT 'The spatial extent of the heritage site in hectares. Used to calculate buffer zones, exclusion areas, and spatial overlap with mining tenements in GIS systems.',
    `site_condition` STRING COMMENT 'Current physical condition of the heritage site based on most recent inspection or monitoring. Tracks degradation, damage, or disturbance over time to inform protection measures.. Valid values are `intact|partially disturbed|significantly disturbed|damaged|destroyed`',
    `site_name` STRING COMMENT 'The name or designation of the cultural heritage site as recognized by the affiliated cultural group or heritage authority. May include traditional language names.',
    `site_reference_number` STRING COMMENT 'External reference number or code assigned to the heritage site by heritage authorities, archaeological surveys, or internal site numbering systems. Used for cross-referencing with heritage registers and survey reports.',
    `site_status` STRING COMMENT 'Current lifecycle status of the heritage site record indicating its protection state and management activity level. Active sites require ongoing monitoring and protection measures. [ENUM-REF-CANDIDATE: active|protected|restricted|under assessment|damaged|destroyed|archived — 7 candidates stripped; promote to reference product]',
    `site_type` STRING COMMENT 'Classification of the cultural heritage site based on its primary cultural or archaeological significance. Determines protection protocols and management requirements. [ENUM-REF-CANDIDATE: sacred site|archaeological site|burial ground|ceremonial area|rock art|historical structure|artifact scatter — 7 candidates stripped; promote to reference product]',
    `survey_date` DATE COMMENT 'The date when the heritage survey or assessment that identified this site was conducted. Important for tracking survey currency and determining if re-assessment is required.',
    `surveyor_name` STRING COMMENT 'Name of the qualified archaeologist, anthropologist, or heritage consultant who conducted the survey and documented the site. Used for professional accountability and follow-up inquiries.',
    `surveyor_organisation` STRING COMMENT 'The consulting firm, university, or heritage authority that employed the surveyor and conducted the heritage assessment. Used for report retrieval and quality assurance.',
    CONSTRAINT pk_cultural_heritage_site PRIMARY KEY(`cultural_heritage_site_id`)
) COMMENT 'Master register of cultural heritage sites, sacred sites, and places of cultural significance identified within or adjacent to the mining tenement area. Captures site name, site type (sacred site, archaeological site, burial ground, ceremonial area, rock art), GPS coordinates, cultural group affiliation, significance description, protection status, no-go zone radius, heritage survey reference, and management restrictions. Complements tenement.heritage_clearance which tracks clearance events; this entity is the SSOT for the heritage site itself.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`heritage_incident` (
    `heritage_incident_id` BIGINT COMMENT 'Unique identifier for the cultural heritage incident record. Primary key.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Heritage incidents impact specific traditional owner groups who are registered as stakeholders. The heritage_incident.traditional_owner_group string attribute should be normalized to a proper FK linki',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Cultural heritage disturbances are typically caused by specific equipment operations (excavator uncovering artefacts, dozer disturbing sacred site, drill rig impacting burial ground). Heritage inciden',
    `cultural_heritage_site_id` BIGINT COMMENT 'Reference to the mine site where the heritage incident occurred.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Cultural heritage incidents (artefact disturbance, site damage) are HSE incidents in mining operations. Integrated incident management systems require linking heritage incidents to parent HSE incident',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Heritage incidents occur during orebody development activities. Incident reporting links cultural heritage disturbance to the specific orebody being mined for root cause analysis and prevention. Real ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Heritage incidents require a named employee as investigation lead and remediation coordinator for root cause analysis, traditional owner consultation, and regulatory reporting. Critical for accountabi',
    `related_heritage_incident_id` BIGINT COMMENT 'Self-referencing FK on heritage_incident (related_heritage_incident_id)',
    `activity_description` STRING COMMENT 'Detailed description of the specific mining or exploration activity that resulted in the heritage incident.',
    `activity_type` STRING COMMENT 'Type of mining or exploration activity that caused or contributed to the heritage disturbance. [ENUM-REF-CANDIDATE: drilling|blasting|excavation|haulage|construction|exploration|rehabilitation|other — 8 candidates stripped; promote to reference product]',
    `area_impacted_hectares` DECIMAL(18,2) COMMENT 'Total area of the heritage site impacted by the disturbance, measured in hectares.',
    `artefacts_disturbed_count` STRING COMMENT 'Number of cultural artefacts disturbed, damaged, or removed during the incident, if quantifiable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this heritage incident record was first created in the system.',
    `discovery_date` DATE COMMENT 'Date when the heritage incident was first identified or reported, distinct from when the disturbance occurred.',
    `heritage_site_name` STRING COMMENT 'Name or designation of the cultural heritage site or area affected by the incident.',
    `heritage_site_reference` STRING COMMENT 'Reference identifier or code for the registered cultural heritage site or area that was impacted, as documented in heritage surveys or registers.',
    `heritage_type` STRING COMMENT 'Classification of the type of cultural heritage impacted (e.g., archaeological site, sacred site, burial ground, rock art, artefact). [ENUM-REF-CANDIDATE: archaeological|sacred_site|burial_ground|rock_art|artefact|cultural_landscape|historical_structure|intangible_heritage — 8 candidates stripped; promote to reference product]',
    `immediate_response_actions` STRING COMMENT 'Description of immediate actions taken upon discovery of the incident to stop further disturbance and secure the site.',
    `impact_description` STRING COMMENT 'Comprehensive description of the nature and extent of the disturbance or damage to the cultural heritage site or artefact.',
    `incident_date` DATE COMMENT 'Date when the cultural heritage disturbance or impact occurred or was discovered.',
    `incident_reference_number` STRING COMMENT 'Externally-known business identifier for the heritage incident, used for regulatory reporting and traditional owner communication.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the heritage incident investigation and remediation process.. Valid values are `reported|under_investigation|investigation_complete|remediation_in_progress|remediation_complete|closed`',
    `incident_timestamp` TIMESTAMP COMMENT 'Precise date and time when the cultural heritage disturbance or impact occurred or was discovered.',
    `investigation_completion_date` DATE COMMENT 'Date when the formal investigation into the heritage incident was completed.',
    `investigation_outcome` STRING COMMENT 'Summary of the investigation findings, including root cause analysis and determination of responsibility.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation into the heritage incident commenced.',
    `investigation_status` STRING COMMENT 'Current status of the formal investigation into the heritage incident.. Valid values are `not_started|in_progress|complete|on_hold`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this heritage incident record was last updated or modified.',
    `location_coordinates` STRING COMMENT 'Geographic coordinates (latitude, longitude) of the heritage incident location for spatial analysis and mapping.',
    `location_description` STRING COMMENT 'Detailed textual description of the specific area or location within the mine site where the heritage disturbance occurred.',
    `regulator_notification_date` DATE COMMENT 'Date when the regulatory authority was formally notified of the heritage incident.',
    `regulator_notified_flag` BOOLEAN COMMENT 'Indicates whether the relevant regulatory authority has been formally notified of the heritage incident as required by law.',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body notified and overseeing the incident response and investigation.',
    `remediation_completion_date` DATE COMMENT 'Date when remediation or restoration activities were completed.',
    `remediation_measures` STRING COMMENT 'Description of remediation, restoration, or mitigation measures implemented or planned to address the heritage impact.',
    `remediation_status` STRING COMMENT 'Current status of remediation or restoration activities for the impacted heritage site.. Valid values are `not_started|planned|in_progress|complete|not_required`',
    `reported_by` STRING COMMENT 'Name or identifier of the person who first reported or discovered the heritage incident.',
    `root_cause` STRING COMMENT 'Identified root cause or contributing factors that led to the heritage incident.',
    `severity_classification` STRING COMMENT 'Classification of the severity or significance of the heritage impact based on extent of disturbance, cultural significance, and irreversibility.. Valid values are `minor|moderate|major|critical|catastrophic`',
    `traditional_owner_notification_date` DATE COMMENT 'Date when traditional owners were formally notified of the heritage incident.',
    `traditional_owner_notified_flag` BOOLEAN COMMENT 'Indicates whether the traditional owners or indigenous custodians have been formally notified of the heritage incident.',
    `work_stoppage_date` DATE COMMENT 'Date when work stoppage was issued for the affected area, if applicable.',
    `work_stoppage_issued_flag` BOOLEAN COMMENT 'Indicates whether a work stoppage order was issued for the affected area following the incident.',
    CONSTRAINT pk_heritage_incident PRIMARY KEY(`heritage_incident_id`)
) COMMENT 'Transactional record of cultural heritage incidents where mining or exploration activities have impacted, disturbed, or potentially disturbed a cultural heritage site or artefact. Captures incident date, site or area affected, activity that caused the disturbance, heritage site reference, severity classification, immediate response actions taken, notification to traditional owners and regulators, investigation outcome, and remediation measures. Supports regulatory compliance and traditional owner relationship management.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`health_program` (
    `health_program_id` BIGINT COMMENT 'Unique identifier for the community health program record. Primary key.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: Community health programs are often funded or mandated under benefit-sharing agreements as part of social investment obligations. The health_program.benefit_sharing_agreement_reference string attribut',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Health program costs are operational expenditure charged to community relations cost centers for budget tracking and IFC PS4 compliance reporting.',
    `mine_site_id` BIGINT COMMENT 'Identifier of the mine site or operation funding or sponsoring the community health program.',
    `procurement_vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Mining companies contract health service vendors (clinics, NGOs, medical suppliers) to deliver community health programs. The implementing_partner text field should be formalized as FK to vendor for p',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Health programs require a named employee as program manager for partner coordination, outcome tracking, and IFC PS4 compliance reporting. Enables performance tracking and workload balancing across com',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Community health programs are delivered to specific target communities who are stakeholders. Currently target_community is text. Normalizing to FK enables tracking which stakeholder communities benefi',
    `parent_health_program_id` BIGINT COMMENT 'Self-referencing FK on health_program (parent_health_program_id)',
    `actual_beneficiaries_count` STRING COMMENT 'Actual number of individuals who have received services or benefits from the health program to date.',
    `approval_date` DATE COMMENT 'Date when the health program was formally approved by the mining company or joint management committee.',
    `approved_by` STRING COMMENT 'Name or title of the executive, committee, or authority that approved the health program.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program budget amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this community health program record was first created in the system.',
    `document_location` STRING COMMENT 'File path, URL, or document management system reference where the full program documentation, agreements, and reports are stored.',
    `end_date` DATE COMMENT 'Planned or actual date when the health program concludes or concluded.',
    `environmental_health_linkage` STRING COMMENT 'Description of any linkages between the health program and environmental impacts of mining operations (e.g., dust control, water quality, vector control).',
    `funding_source` STRING COMMENT 'Primary source of financial support for the program (company CSR budget, benefit-sharing agreement, government grant, donor contribution, joint funding).. Valid values are `company_csr|benefit_sharing_agreement|government_grant|donor_contribution|joint_funding`',
    `geographic_region` STRING COMMENT 'Geographic area, district, or administrative region where the health program is implemented.',
    `health_focus_area` STRING COMMENT 'Primary health domain or disease category that the program addresses (malaria, HIV/AIDS, nutrition, maternal health, mental health, water and sanitation).. Valid values are `malaria|hiv_aids|nutrition|maternal_health|mental_health|water_sanitation`',
    `ifc_ps4_alignment` STRING COMMENT 'Description of how the program aligns with IFC Performance Standard 4 obligations on Community Health, Safety and Security.',
    `key_performance_indicators` STRING COMMENT 'List or description of measurable KPIs used to track program effectiveness (e.g., vaccination coverage rate, malaria incidence reduction, maternal mortality ratio).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this community health program record was last updated or modified.',
    `partner_type` STRING COMMENT 'Classification of the implementing partner organization (NGO, government agency, healthcare provider, community organization, international agency).. Valid values are `ngo|government|healthcare_provider|community_organization|international_agency`',
    `program_budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the health program over its full funding period.',
    `program_code` STRING COMMENT 'Unique business identifier code assigned to the health program for external reference and reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_name` STRING COMMENT 'Full descriptive name of the community health program.',
    `program_objectives` STRING COMMENT 'Detailed description of the health outcomes, goals, and objectives the program aims to achieve in the target community.',
    `program_status` STRING COMMENT 'Current lifecycle status of the health program indicating its operational state.. Valid values are `planned|active|suspended|completed|cancelled`',
    `reporting_frequency` STRING COMMENT 'Frequency at which program progress and outcomes are reported to stakeholders (monthly, quarterly, biannual, annual).. Valid values are `monthly|quarterly|biannual|annual`',
    `risk_assessment` STRING COMMENT 'Summary of identified risks to program delivery (e.g., political instability, funding shortfalls, partner capacity constraints) and mitigation measures.',
    `stakeholder_consultation_date` DATE COMMENT 'Date when community stakeholders were consulted or engaged in the design or approval of the health program.',
    `start_date` DATE COMMENT 'Date when the health program officially commenced or is scheduled to commence.',
    `sustainability_plan` STRING COMMENT 'Description of the strategy or plan to ensure the health program continues to deliver benefits beyond the mining operations direct involvement.',
    `target_beneficiaries_count` STRING COMMENT 'Estimated number of individuals in the community expected to directly benefit from the health program.',
    CONSTRAINT pk_health_program PRIMARY KEY(`health_program_id`)
) COMMENT 'Master record of community health and wellbeing programs funded or co-delivered by the mining operation in host communities. Captures program name, health focus area (malaria, HIV/AIDS, nutrition, maternal health, mental health, water and sanitation), target community, implementing partner, program budget, funding period, key performance indicators, and alignment to IFC Performance Standard 4 (Community Health, Safety and Security) obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`security_incident` (
    `security_incident_id` BIGINT COMMENT 'Unique identifier for the security incident record. Primary key.',
    `grievance_id` BIGINT COMMENT 'Reference to the related grievance record if a formal grievance was lodged in connection with this security incident.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Security incidents involving community members (protests, trespassing, confrontations) are HSE incidents requiring integrated management. Links security events to HSE incident framework for unified in',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Security incidents require a named employee as investigating officer for root cause analysis, VPSHR compliance assessment, and follow-up action coordination. Critical for accountability and competency',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Security incidents at mine sites frequently involve equipment (theft of light vehicles, damage to parked haul trucks, unauthorized use of dozers, fuel theft from excavators). Security investigation an',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Security incidents involving community members should link to the stakeholder register for proper tracking and relationship management. The security_incident.parties_involved string attribute suggests',
    `site_id` BIGINT COMMENT 'Reference to the mine site where the security incident occurred.',
    `related_security_incident_id` BIGINT COMMENT 'Self-referencing FK on security_incident (related_security_incident_id)',
    `closure_date` DATE COMMENT 'Date when the security incident was formally closed after all investigations and follow-up actions were completed.',
    `community_area_flag` BOOLEAN COMMENT 'Indicates whether the incident occurred in a community area adjacent to mine operations (True) or within mine operational boundaries (False).',
    `community_member_involved_flag` BOOLEAN COMMENT 'Indicates whether community members were involved in the security incident (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this security incident record was first created in the system.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Estimated financial loss resulting from the security incident, including theft, property damage, and operational disruption.',
    `fatalities_reported_flag` BOOLEAN COMMENT 'Indicates whether any fatalities occurred as a result of the security incident (True/False).',
    `follow_up_actions` STRING COMMENT 'Description of follow-up actions taken or planned in response to the security incident, including corrective measures, stakeholder engagement, and policy changes.',
    `grievance_lodged_flag` BOOLEAN COMMENT 'Indicates whether a formal grievance was lodged by community members in relation to the security incident (True/False).',
    `incident_date` DATE COMMENT 'The date on which the security incident occurred.',
    `incident_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the security incident for tracking and reporting purposes.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the security incident in the investigation and resolution workflow.. Valid values are `reported|under_investigation|resolved|closed|escalated|pending`',
    `incident_timestamp` TIMESTAMP COMMENT 'The precise date and time when the security incident occurred, capturing the real-world event time.',
    `incident_type` STRING COMMENT 'Classification of the security incident. Categories include illegal mining (artisanal and small-scale mining intrusions), trespass, theft, civil unrest, security force interactions with community members, and vandalism.. Valid values are `illegal_mining|trespass|theft|civil_unrest|security_force_interaction|vandalism`',
    `injuries_reported_flag` BOOLEAN COMMENT 'Indicates whether any injuries were reported as a result of the security incident (True/False).',
    `injury_severity` STRING COMMENT 'Classification of the severity of injuries sustained during the incident.. Valid values are `minor|moderate|serious|critical`',
    `investigation_completion_date` DATE COMMENT 'Date when the investigation of the security incident was completed.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of the security incident commenced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this security incident record was last modified or updated.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement authorities were notified of the security incident (True/False).',
    `law_enforcement_reference` STRING COMMENT 'Reference number or case identifier assigned by law enforcement authorities for the security incident.',
    `location_coordinates` STRING COMMENT 'Geographic coordinates (latitude, longitude) of the incident location for spatial analysis and mapping.',
    `location_description` STRING COMMENT 'Detailed textual description of the specific location where the security incident occurred, including landmarks, zones, or community areas adjacent to mine operations.',
    `loss_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated loss amount.. Valid values are `^[A-Z]{3}$`',
    `media_coverage_flag` BOOLEAN COMMENT 'Indicates whether the security incident received media coverage or public attention (True/False).',
    `number_of_fatalities` STRING COMMENT 'Total count of fatalities resulting from the security incident.',
    `number_of_individuals_involved` STRING COMMENT 'Count of individuals involved in the security incident, including perpetrators, victims, and witnesses.',
    `number_of_injuries` STRING COMMENT 'Total count of individuals injured during the security incident.',
    `parties_involved` STRING COMMENT 'Description of the parties involved in the security incident, including community members, security personnel, contractors, or other stakeholders.',
    `property_damage_description` STRING COMMENT 'Description of property damage sustained during the incident, including affected assets and estimated impact.',
    `property_damage_flag` BOOLEAN COMMENT 'Indicates whether property damage occurred during the security incident (True/False).',
    `regulatory_report_reference` STRING COMMENT 'Reference number or identifier for the regulatory report submitted in relation to the security incident.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the security incident requires formal reporting to regulatory authorities (True/False).',
    `reported_by_name` STRING COMMENT 'Name of the individual who reported the security incident.',
    `reported_by_role` STRING COMMENT 'Role or position of the individual who reported the security incident.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the security incident was officially reported to management or authorities.',
    `security_force_type` STRING COMMENT 'Type of security force that responded to the incident: private security contractors, public security (police/military), mine internal security, or joint response.. Valid values are `private_security|public_security|mine_security|joint_response`',
    `security_response_description` STRING COMMENT 'Detailed description of the security response actions taken in response to the incident, including personnel deployed, tactics used, and timeline of response.',
    `slo_risk_level` STRING COMMENT 'Assessment of the risk level this security incident poses to the mines social licence to operate with the community.. Valid values are `low|medium|high|critical`',
    `use_of_force_description` STRING COMMENT 'Detailed description of the type and level of force used during the security response, if applicable.',
    `use_of_force_flag` BOOLEAN COMMENT 'Indicates whether force was used by security personnel during the incident response (True/False).',
    `vpshr_assessment_notes` STRING COMMENT 'Detailed notes and findings from the VPSHR compliance assessment, including any violations or areas of concern.',
    `vpshr_compliance_assessment` STRING COMMENT 'Assessment of whether the security response and incident handling complied with the Voluntary Principles on Security and Human Rights framework.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    CONSTRAINT pk_security_incident PRIMARY KEY(`security_incident_id`)
) COMMENT 'Transactional record of security incidents involving community members or occurring in community areas adjacent to mine operations, including illegal mining (artisanal and small-scale mining intrusions), trespass, theft, civil unrest, and security force interactions with community members. Captures incident date, location, incident type, parties involved, security response, injuries or fatalities, Voluntary Principles on Security and Human Rights (VPSHR) compliance assessment, and follow-up actions. Distinct from hse.incident which covers occupational safety incidents.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`fpic_process` (
    `fpic_process_id` BIGINT COMMENT 'Unique identifier for the FPIC process record. Primary key.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: FPIC processes with indigenous peoples often result in or reference benefit-sharing arrangements as part of the consent agreement. The fpic_process.benefit_sharing_arrangement_reference string attribu',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: FPIC consultation costs (facilitation, legal, translation) are charged to exploration or development cost centers for budget tracking and project cost allocation.',
    `licence_id` BIGINT COMMENT 'Foreign key linking to exploration.licence. Business justification: FPIC processes are required for exploration licences in indigenous territories. Regulatory compliance, social licence, and legal defensibility depend on tracking which FPIC process applies to which li',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: FPIC (Free, Prior and Informed Consent) processes are conducted with specific indigenous peoples/groups who are critical stakeholders. Currently indigenous_group_name is text. Normalizing to FK ensure',
    `land_compensation_agreement_id` BIGINT COMMENT 'Foreign key linking to community.land_compensation_agreement. Business justification: FPIC processes often involve land access and compensation agreements with indigenous landowners. The fpic_process.compensation_agreement_reference string attribute should be normalized to a proper FK.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: FPIC processes are conducted for specific orebodies on traditional lands. Indigenous consent is sought for development of identified mineral resources within traditional territories. Real business pro',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FPIC processes require a named employee as responsible officer for consultation coordination, consent documentation, and regulatory compliance. Critical for audit trail and competency verification in ',
    `site_id` BIGINT COMMENT 'Identifier of the mine site or operation associated with this FPIC process.',
    `tenement_id` BIGINT COMMENT 'Identifier of the mining tenement or licence area where the activity requiring consent will take place.',
    `preceding_fpic_process_id` BIGINT COMMENT 'Self-referencing FK on fpic_process (preceding_fpic_process_id)',
    `activity_requiring_consent` STRING COMMENT 'Description of the mining activity or project phase requiring FPIC (e.g., exploration drilling, mine development, infrastructure construction, land access).',
    `activity_type` STRING COMMENT 'Classification of the mining activity requiring consent.. Valid values are `exploration|mine_development|extraction|infrastructure|closure|expansion`',
    `authorised_signatory_name` STRING COMMENT 'Name of the authorised representative or elder who signed the consent agreement on behalf of the indigenous group.',
    `authorised_signatory_title` STRING COMMENT 'Title or role of the authorised signatory within the indigenous group governance structure (e.g., Chief, Elder, Council Representative).',
    `conditions_attached_to_consent` STRING COMMENT 'Specific conditions, requirements, or mitigation measures that the indigenous group has attached to their consent decision.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this FPIC record, reflecting sensitivity of indigenous group information and negotiation details.. Valid values are `public|internal|confidential|restricted`',
    `consent_decision_date` DATE COMMENT 'Date on which the indigenous group formally provided or withheld consent for the proposed activity.',
    `consent_status` STRING COMMENT 'Current status of the FPIC process indicating whether consent has been given, withheld, or is under negotiation.. Valid values are `consent_given|consent_withheld|ongoing_negotiation|process_initiated|suspended|withdrawn`',
    `consultation_completion_date` DATE COMMENT 'Date when the consultation phase of the FPIC process was completed.',
    `consultation_process_description` STRING COMMENT 'Detailed description of the consultation process conducted, including methods, meetings, information sharing, and engagement approach used to obtain FPIC.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FPIC process record was first created in the system.',
    `cultural_heritage_provisions` STRING COMMENT 'Specific provisions agreed to protect cultural heritage sites, sacred areas, and traditional practices within the affected territory.',
    `document_location` STRING COMMENT 'File path or document management system reference where the complete FPIC documentation, agreements, and meeting records are stored.',
    `grievance_mechanism_linked_flag` BOOLEAN COMMENT 'Indicates whether a grievance mechanism has been established and communicated to the indigenous group as part of the FPIC process.',
    `independent_facilitator_name` STRING COMMENT 'Name of the independent third-party facilitator or mediator engaged to support the FPIC process, if applicable.',
    `information_disclosure_date` DATE COMMENT 'Date when comprehensive project information was disclosed to the indigenous group in culturally appropriate formats and languages.',
    `interpreter_provided_flag` BOOLEAN COMMENT 'Indicates whether professional interpreters were provided to facilitate communication during the FPIC process.',
    `language_used` STRING COMMENT 'Primary language(s) used during the FPIC consultation process to ensure culturally appropriate communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FPIC process record was last updated, reflecting the most recent change to consent status or process details.',
    `legal_review_completed_flag` BOOLEAN COMMENT 'Indicates whether the FPIC process and agreement have undergone legal review for compliance with national and international standards.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the FPIC agreement and consent status.',
    `notes` STRING COMMENT 'Additional notes, observations, or context regarding the FPIC process, including any special circumstances or considerations.',
    `process_initiation_date` DATE COMMENT 'Date when the FPIC consultation process was formally initiated with the indigenous group.',
    `process_reference_number` STRING COMMENT 'Externally-known unique reference code for the FPIC process, used in regulatory reporting and stakeholder communications.. Valid values are `^FPIC-[A-Z0-9]{6,12}$`',
    `regulatory_submission_reference` STRING COMMENT 'Reference number for any regulatory submission or disclosure related to this FPIC process (e.g., environmental approval, mining permit application).',
    `responsible_department` STRING COMMENT 'Department or business unit responsible for the FPIC process (e.g., Community Relations, Social Performance, Sustainability).',
    `review_trigger_conditions` STRING COMMENT 'Conditions or events that would trigger a review or renewal of the FPIC process (e.g., material project changes, new impacts identified, time-based review).',
    `sia_reference_number` STRING COMMENT 'Reference to the Social Impact Assessment that identified the need for this FPIC process.',
    `traditional_territory_name` STRING COMMENT 'Name of the traditional lands, territories, or resources affected by the proposed mining activity.',
    CONSTRAINT pk_fpic_process PRIMARY KEY(`fpic_process_id`)
) COMMENT 'Master record of Free, Prior and Informed Consent (FPIC) processes conducted with indigenous peoples and traditional owner groups for mining activities affecting their lands, territories, and resources. Captures FPIC process reference, indigenous group, activity requiring consent, consultation process description, consent status (consent given, consent withheld, ongoing negotiation), conditions attached to consent, consent date, authorised signatories, and review triggers. Required under IFC PS7 and UNDRIP obligations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`commitment` (
    `commitment_id` BIGINT COMMENT 'Unique identifier for the community commitment record. Primary key for the community commitment register.',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Foreign key linking to community.benefit_sharing_agreement. Business justification: Benefit-sharing agreements contain commitments to communities regarding employment, procurement, infrastructure, and benefit distribution. This is a parallel FK to land_compensation_agreement_id - a c',
    `engagement_plan_id` BIGINT COMMENT 'Foreign key linking to community.engagement_plan. Business justification: Commitments can arise from engagement plans as part of structured stakeholder engagement processes. The commitment.commitment_source attribute indicates multiple sources; engagement plans are one such',
    `land_compensation_agreement_id` BIGINT COMMENT 'Foreign key linking to community.land_compensation_agreement. Business justification: Land compensation agreements generate formal commitments to landowners and communities. The commitment.agreement_reference string attribute should be normalized to a proper FK. This FK is optional (nu',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Community commitments require a named employee as accountable manager for delivery tracking, stakeholder communication, and evidence submission. Enables performance tracking and workload balancing acr',
    `site_id` BIGINT COMMENT 'Foreign key reference to the mine site or operational location associated with this commitment. Links to the site master register.',
    `social_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to community.social_impact_assessment. Business justification: Many community commitments arise from Social Impact Assessments (SIAs). Currently sia_reference_number is a text field. Adding FK enables tracking which commitments originated from which SIA, supports',
    `stakeholder_id` BIGINT COMMENT 'Foreign key reference to the stakeholder or stakeholder group to whom this commitment was made. Links to the stakeholder master register.',
    `parent_commitment_id` BIGINT COMMENT 'Self-referencing FK on commitment (parent_commitment_id)',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual financial cost incurred to fulfill this commitment. Expressed in the currency specified in the currency code field. Null if commitment is not yet completed or costs are not yet finalized.',
    `approval_date` DATE COMMENT 'The date on which this commitment was formally approved by company management or the board. Used for governance and audit trail.',
    `approved_by_name` STRING COMMENT 'Full name of the executive or manager who approved this commitment on behalf of the company. Used for accountability and governance tracking.',
    `commitment_category` STRING COMMENT 'Classification of the commitment by its binding nature. Regulatory commitments arise from government approvals and permits, contractual commitments from signed agreements, voluntary commitments from company initiatives, and public statement commitments from formal company communications.. Valid values are `regulatory|contractual|voluntary|public_statement`',
    `commitment_date` DATE COMMENT 'The date on which the commitment was formally made or agreed. This is the business event date when the obligation was established.',
    `commitment_description` STRING COMMENT 'Detailed description of the commitment including the specific obligation, deliverable, or action that the company has committed to undertake for the community or stakeholder.',
    `commitment_source` STRING COMMENT 'The origin or source document from which this commitment arose. Examples include Social Impact Assessment (SIA) reports, Environmental Impact Statement (EIS), community consultation records, land compensation agreements, regulatory approval conditions, benefit-sharing agreements, or public statements by company leadership.',
    `commitment_status` STRING COMMENT 'Current lifecycle status of the commitment indicating whether it is in draft, active and pending action, in progress, completed and fulfilled, overdue, cancelled, or deferred to a later date. [ENUM-REF-CANDIDATE: draft|active|in_progress|completed|overdue|cancelled|deferred — 7 candidates stripped; promote to reference product]',
    `commitment_type` STRING COMMENT 'Classification of the commitment by the nature of the obligation. Categories include financial contributions, infrastructure development, employment guarantees, training programs, environmental protection, health and safety measures, cultural heritage preservation, resettlement support, benefit-sharing arrangements, and other commitments. [ENUM-REF-CANDIDATE: financial|infrastructure|employment|training|environmental|health_safety|cultural_heritage|resettlement|benefit_sharing|other — 10 candidates stripped; promote to reference product]',
    `completion_date` DATE COMMENT 'The actual date on which the commitment was fulfilled and completed. Null if the commitment is not yet completed.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of completion for this commitment, expressed as a value between 0.00 and 100.00. Used for progress tracking and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this commitment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated and actual cost amounts. Examples include USD, AUD, CAD, ZAR.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'The target date by which this commitment must be fulfilled or completed. Used for tracking overdue commitments and reporting compliance.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this commitment requires escalation to senior management or executive leadership due to delays, risks, or stakeholder concerns. True if escalation is required, False otherwise.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated financial cost or budget allocated to fulfill this commitment. Expressed in the currency specified in the currency code field.',
    `evidence_document_location` STRING COMMENT 'File path, URL, or document management system reference where supporting evidence and documentation for this commitment is stored.',
    `evidence_of_fulfilment` STRING COMMENT 'Description or reference to the evidence, documentation, or proof that demonstrates this commitment has been fulfilled. May include report references, photos, receipts, certificates, or stakeholder sign-offs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this commitment record was last updated or modified. Used for audit trail and change tracking.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review or progress check of this commitment. Used for forward planning and compliance monitoring.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this commitment. Used for capturing information that does not fit in other structured fields.',
    `priority_level` STRING COMMENT 'Priority classification of this commitment based on its importance, urgency, regulatory significance, or stakeholder sensitivity. Used for resource allocation and management focus.. Valid values are `critical|high|medium|low`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this commitment for tracking and reporting purposes. Used in stakeholder communications and regulatory submissions.',
    `regulatory_condition_reference` STRING COMMENT 'Reference number or identifier of the specific regulatory approval condition, permit condition, or consent requirement that mandates this commitment. Used for regulatory compliance tracking.',
    `reporting_frequency` STRING COMMENT 'The frequency at which progress or completion of this commitment must be reported. Options include monthly, quarterly, semi-annually, annually, ad-hoc, or not required.. Valid values are `monthly|quarterly|semi_annually|annually|ad_hoc|not_required`',
    `reporting_obligation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this commitment requires formal reporting to regulators, stakeholders, or in public disclosures. True if reporting is required, False otherwise.',
    `reporting_recipient` STRING COMMENT 'Name or identifier of the party or authority to whom progress or completion of this commitment must be reported. Examples include regulatory agencies, community representatives, or board committees.',
    `responsible_department` STRING COMMENT 'Name of the department, division, or business unit responsible for delivering this commitment. Examples include Community Relations, Environment, Operations, Human Resources, or Procurement.',
    `review_date` DATE COMMENT 'The date when this commitment was last reviewed for progress, status, or ongoing relevance. Used for periodic commitment audits.',
    `risk_level` STRING COMMENT 'Assessment of the risk to social licence to operate (SLO) or stakeholder relations if this commitment is not fulfilled. Used for prioritization and escalation.. Valid values are `very_high|high|medium|low|very_low`',
    `sia_reference_number` STRING COMMENT 'Reference number of the Social Impact Assessment (SIA) from which this commitment originated. Links commitment to the impact assessment process.',
    `source_document_reference` STRING COMMENT 'Reference number, identifier, or location of the source document where this commitment is formally recorded. Used for audit trail and evidence of commitment origin.',
    `stakeholder_acceptance_status` STRING COMMENT 'Status indicating whether the stakeholder or community has accepted the fulfilment of this commitment. Options include accepted, pending review, disputed, or not applicable.. Valid values are `accepted|pending|disputed|not_applicable`',
    `stakeholder_feedback` STRING COMMENT 'Free-text field capturing feedback, comments, or concerns raised by stakeholders regarding the fulfilment or progress of this commitment.',
    `target_community` STRING COMMENT 'Name or identifier of the specific community, stakeholder group, or geographic area that is the beneficiary or subject of this commitment.',
    `title` STRING COMMENT 'Short descriptive title or name of the commitment that summarizes the obligation in business-friendly language.',
    CONSTRAINT pk_commitment PRIMARY KEY(`commitment_id`)
) COMMENT 'Master register of all formal commitments made to communities, regulators, and stakeholders arising from social impact assessments, consultation processes, agreements, and regulatory conditions. Captures commitment description, commitment source (SIA, agreement, regulatory condition, public statement), responsible manager, due date, completion status, evidence of fulfilment, and reporting obligation. Serves as the SSOT for tracking all community-facing obligations and their delivery status.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`commitment_evidence` (
    `commitment_evidence_id` BIGINT COMMENT 'Unique identifier for the commitment evidence record. Primary key for the commitment evidence entity.',
    `commitment_id` BIGINT COMMENT 'Reference to the parent community commitment that this evidence supports. Links to the commitment being fulfilled.',
    `employee_id` BIGINT COMMENT 'Reference to the system user who last modified this evidence record. Establishes accountability for data changes in the audit trail.',
    `primary_commitment_employee_id` BIGINT COMMENT 'Reference to the system user who submitted the evidence. Establishes accountability and audit trail for evidence submission.',
    `site_id` BIGINT COMMENT 'Reference to the mine site where the commitment is being fulfilled. Enables site-level compliance tracking and reporting.',
    `superseded_commitment_evidence_id` BIGINT COMMENT 'Self-referencing FK on commitment_evidence (superseded_commitment_evidence_id)',
    `confidentiality_level` STRING COMMENT 'Data classification level of the evidence document. Controls access and disclosure in accordance with information security and stakeholder privacy requirements.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this evidence record was first created in the database. Provides audit trail for data lineage and compliance.',
    `document_format` STRING COMMENT 'File format of the submitted evidence document. Supports document management and accessibility requirements. [ENUM-REF-CANDIDATE: pdf|docx|xlsx|jpg|png|mp4|zip — 7 candidates stripped; promote to reference product]',
    `document_reference` STRING COMMENT 'File path, URL, or document management system reference pointing to the physical evidence artifact. Enables retrieval of supporting documentation.',
    `document_size_mb` DECIMAL(18,2) COMMENT 'Size of the evidence document file in megabytes. Used for storage management and system performance optimization.',
    `evidence_description` STRING COMMENT 'Detailed narrative describing the evidence content, context, and how it demonstrates fulfillment of the commitment. Provides business context for reviewers and auditors.',
    `evidence_period_end_date` DATE COMMENT 'End date of the period that this evidence covers. Defines the temporal scope of the evidence for compliance tracking.',
    `evidence_period_start_date` DATE COMMENT 'Start date of the period that this evidence covers. Defines the temporal scope of the evidence for compliance tracking.',
    `evidence_reference_number` STRING COMMENT 'Business identifier for the evidence submission. Externally-known unique code used for tracking and audit purposes.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `evidence_status` STRING COMMENT 'Current state of the evidence in the verification workflow. Tracks progression from submission through verification to final acceptance or rejection.. Valid values are `submitted|under_review|verified|rejected|pending_clarification|archived`',
    `evidence_type` STRING COMMENT 'Classification of the evidence submission format. Categorizes the nature of proof provided to demonstrate commitment fulfillment.. Valid values are `report|photo|video|third_party_verification|audit_finding|inspection_certificate`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this evidence record was last updated. Tracks data currency and supports change audit requirements.',
    `lender_reporting_flag` BOOLEAN COMMENT 'Indicates whether this evidence must be included in lender covenant compliance reports. Supports project finance and Equator Principles reporting requirements.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this evidence must be included in regulatory compliance reports. Supports Environmental Impact Statement (EIS) and mining permit compliance reporting.',
    `rejection_reason` STRING COMMENT 'Explanation of why evidence was rejected. Provides feedback to submitters and supports process improvement. Populated only when verification_outcome is rejected.',
    `stakeholder_notification_date` DATE COMMENT 'Date when stakeholders were notified of the evidence submission. Tracks compliance with transparency commitments and grievance mechanism requirements.',
    `stakeholder_notification_required_flag` BOOLEAN COMMENT 'Indicates whether affected stakeholders must be notified of this evidence submission. Supports transparency and social licence to operate (SLO) requirements.',
    `submission_date` DATE COMMENT 'Date when the evidence was formally submitted for verification. Key business event timestamp for compliance tracking and audit trail.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the evidence was submitted into the system. Provides granular audit trail for regulatory reporting.',
    `submitted_by_department` STRING COMMENT 'Organizational department or business unit of the submitter. Enables departmental accountability tracking and reporting.',
    `submitted_by_name` STRING COMMENT 'Full name of the person who submitted the evidence. Provides human-readable identification for reporting and audit purposes.',
    `submitted_by_role` STRING COMMENT 'Job title or role of the person who submitted the evidence. Provides context on authority and responsibility level of submitter.',
    `third_party_verifier_accreditation` STRING COMMENT 'Professional accreditation or certification held by the third-party verifier. Demonstrates verifier competence and independence for regulatory and lender reporting.',
    `third_party_verifier_organisation` STRING COMMENT 'Name of external organization that provided independent verification. Applicable when evidence_type is third_party_verification. Enhances credibility for stakeholder reporting.',
    `verification_date` DATE COMMENT 'Date when the evidence was formally verified and accepted. Key milestone for compliance reporting and commitment tracking.',
    `verification_method` STRING COMMENT 'Approach used to verify the evidence. Documents the verification methodology for audit trail and quality assurance purposes.. Valid values are `desktop_review|site_inspection|stakeholder_interview|third_party_audit|document_analysis`',
    `verification_notes` STRING COMMENT 'Detailed comments from the verifier explaining the verification decision, findings, and any conditions or recommendations. Critical for audit trail and continuous improvement.',
    `verification_outcome` STRING COMMENT 'Final determination of the verification process. Records whether the evidence successfully demonstrates commitment fulfillment.. Valid values are `accepted|rejected|partially_accepted|requires_additional_evidence`',
    `verifier_name` STRING COMMENT 'Full name of the person who verified the evidence. Provides human-readable identification for audit trail and reporting.',
    `verifier_role` STRING COMMENT 'Job title or role of the person who verified the evidence. Demonstrates appropriate authority level for verification decisions.',
    CONSTRAINT pk_commitment_evidence PRIMARY KEY(`commitment_evidence_id`)
) COMMENT 'Transactional record of evidence submissions and verification events demonstrating fulfilment of a community commitment. Captures evidence submission date, commitment reference, evidence type (report, photo, third-party verification, audit finding), evidence description, document reference, submitted by, verification status, and verifier. Provides the audit trail for commitment compliance reporting to regulators, lenders, and community stakeholders.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`stakeholder_engagement` (
    `stakeholder_engagement_id` BIGINT COMMENT 'Unique identifier for this stakeholder engagement relationship record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is designated to engage with the stakeholder. References the employee master record.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to the community stakeholder being engaged. References the stakeholder master register.',
    `designation_authority` STRING COMMENT 'Name or role of the person or body that authorized this engagement designation (e.g., Community Relations Manager, Site General Manager). Used for governance and accountability.',
    `end_date` DATE COMMENT 'Date when this engagement relationship ended or the employee was no longer designated for this stakeholder. Null for active engagements. Used for historical tracking and handover management.',
    `engagement_role` STRING COMMENT 'Specific role or function the employee performs in engaging with this stakeholder. May include responsibilities such as consultation lead, benefit negotiation, cultural protocol advisor, or grievance resolution coordinator.',
    `engagement_status` STRING COMMENT 'Current status of this engagement relationship. Active indicates ongoing engagement responsibility; Inactive indicates historical record; Suspended indicates temporary pause; Transitioning indicates handover in progress.',
    `last_interaction_date` DATE COMMENT 'Date of the most recent documented interaction between this employee and this stakeholder. Used for tracking engagement frequency and relationship maintenance.',
    `notes` STRING COMMENT 'Free-text field for documenting important context about this engagement relationship, including handover notes, special protocols, historical context, or relationship sensitivities.',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this employee is the primary/lead contact for this stakeholder. True means this is the main point of contact; false indicates a supporting or secondary role. Used for escalation protocols and communication routing.',
    `relationship_type` STRING COMMENT 'Classification of the nature of the engagement relationship between the employee and stakeholder. Defines the formal capacity in which the employee engages with the stakeholder (e.g., Primary Contact, Technical Liaison, Executive Sponsor).',
    `start_date` DATE COMMENT 'Date when this employee was formally designated to engage with this stakeholder in this capacity. Used for tracking engagement history and continuity of relationships.',
    CONSTRAINT pk_stakeholder_engagement PRIMARY KEY(`stakeholder_engagement_id`)
) COMMENT 'This association product represents the formal engagement relationship between mine employees and community stakeholders. It captures which employees are designated to engage with which stakeholders, in what capacity, and over what time period. Each record links one employee to one stakeholder with attributes that define the nature, timing, and status of that engagement relationship.. Existence Justification: In mining operations, community stakeholder engagement is a formal, managed business process where multiple employees engage with each stakeholder in different capacities (e.g., site manager as executive sponsor, community relations officer as primary contact, environmental manager as technical liaison), and each employee engages with multiple stakeholders across different communities and interest groups. The business actively manages these engagement relationships with designated roles, time periods, and primary contact designations to ensure continuity, cultural protocol compliance, and accountability in community relations.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`stakeholder_consultation` (
    `stakeholder_consultation_id` BIGINT COMMENT 'Unique surrogate identifier for each stakeholder consultation record',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to the Life of Mine plan being consulted on',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to the community stakeholder being consulted',
    `agreement_reference` STRING COMMENT 'Reference identifier to any formal agreement, memorandum of understanding, or consent document resulting from this consultation (e.g., land use agreement number, benefit sharing agreement ID).',
    `consent_status` STRING COMMENT 'The status of consent or approval from this stakeholder for this specific LOM plan. Particularly critical for indigenous stakeholders where Free Prior and Informed Consent (FPIC) is required.',
    `consultation_conducted_by` STRING COMMENT 'Name or identifier of the company representative or team who conducted this consultation. Used for accountability and follow-up.',
    `consultation_date` DATE COMMENT 'The date on which formal consultation with this stakeholder regarding this LOM plan occurred. Used for regulatory compliance reporting and social licence tracking.',
    `consultation_outcome` STRING COMMENT 'Free-text summary of the consultation outcome, including key concerns raised, commitments made, and any conditions attached to stakeholder support.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this consultation record was created in the data platform.',
    `engagement_phase` STRING COMMENT 'The mine lifecycle phase during which this consultation occurred. Critical for tracking consultation requirements across different regulatory and planning stages.',
    `next_consultation_required_date` DATE COMMENT 'The date by which follow-up consultation with this stakeholder on this LOM plan is required, based on regulatory requirements or agreement terms.',
    `notification_method` STRING COMMENT 'The method used to notify and engage this stakeholder about this LOM plan. Must align with stakeholders preferred communication channel and cultural considerations.',
    `regulatory_requirement_met` BOOLEAN COMMENT 'Indicates whether this consultation satisfied applicable regulatory requirements for stakeholder engagement (e.g., Environmental Impact Assessment consultation requirements).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this consultation record was last updated.',
    CONSTRAINT pk_stakeholder_consultation PRIMARY KEY(`stakeholder_consultation_id`)
) COMMENT 'This association product represents the formal consultation and engagement process between a Life of Mine plan and community stakeholders. It captures the regulatory and social licence requirements for stakeholder engagement during mine planning, including consultation dates, consent status, agreement references, and notification methods. Each record links one LOM plan to one stakeholder with attributes that exist only in the context of this specific consultation relationship.. Existence Justification: In mining operations, Life of Mine plans require formal consultation with multiple stakeholder groups (traditional owners, local communities, government bodies, NGOs) to obtain social licence and meet regulatory requirements. Each LOM plan must engage with multiple stakeholders across different phases (feasibility, approval, operation, closure), and each stakeholder participates in consultations for multiple mine plans over time (expansions, amendments, closures). The business actively manages this as a Stakeholder Consultation Register tracking consultation dates, consent status, agreement references, and engagement phases.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` (
    `beneficiary_trust_fund_id` BIGINT COMMENT 'Primary key for beneficiary_trust_fund',
    `benefit_sharing_agreement_id` BIGINT COMMENT 'Reference to the land compensation or benefit-sharing agreement that mandates this trust fund.',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site or operation that established and funds this trust.',
    `stakeholder_id` BIGINT COMMENT 'Reference to the primary community that benefits from this trust fund.',
    `parent_beneficiary_trust_fund_id` BIGINT COMMENT 'Self-referencing FK on beneficiary_trust_fund (parent_beneficiary_trust_fund_id)',
    `annual_contribution_amount` DECIMAL(18,2) COMMENT 'The committed annual contribution amount from the mining operation to the trust fund.',
    `audit_frequency` STRING COMMENT 'The scheduled frequency at which independent audits of the trust fund are conducted.',
    `beneficiary_count` STRING COMMENT 'Total number of individuals or households registered as beneficiaries of this trust fund.',
    `closure_date` DATE COMMENT 'The date on which the trust fund was formally closed or terminated. Null for active funds.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trust fund record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this trust fund.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'The current total balance of the trust fund including all contributions, earnings, and disbursements to date.',
    `disbursement_frequency` STRING COMMENT 'The scheduled frequency at which funds are disbursed to beneficiaries or projects.',
    `eligibility_criteria` STRING COMMENT 'Description of the criteria that individuals or groups must meet to qualify as beneficiaries of the fund.',
    `establishment_date` DATE COMMENT 'The date on which the beneficiary trust fund was formally established and became operational.',
    `fund_code` STRING COMMENT 'Unique alphanumeric code assigned to the trust fund for internal tracking and reporting purposes.',
    `fund_name` STRING COMMENT 'The official name of the beneficiary trust fund established for community benefit sharing.',
    `fund_purpose_description` STRING COMMENT 'Detailed description of the intended purpose and objectives of the trust fund as defined in the trust deed.',
    `fund_status` STRING COMMENT 'Current operational status of the beneficiary trust fund in its lifecycle.',
    `fund_type` STRING COMMENT 'Classification of the trust fund based on its primary purpose and benefit area.',
    `governance_structure` STRING COMMENT 'The governance model used to oversee and make decisions regarding the trust fund.',
    `grievance_mechanism_available` BOOLEAN COMMENT 'Indicates whether a formal grievance mechanism is available for beneficiaries to raise concerns about fund management.',
    `initial_capital_amount` DECIMAL(18,2) COMMENT 'The initial capital contribution made to establish the trust fund at inception.',
    `investment_strategy` STRING COMMENT 'Description of the investment approach used to grow the trust fund capital while managing risk.',
    `last_audit_date` DATE COMMENT 'The date of the most recent independent audit of the trust fund.',
    `legal_jurisdiction` STRING COMMENT 'The legal jurisdiction under which the trust fund is established and governed.',
    `minimum_balance_threshold` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the trust fund to ensure sustainability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this trust fund record was last modified in the system.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next independent audit of the trust fund.',
    `notes` STRING COMMENT 'Free-text field for capturing additional administrative notes, special conditions, or contextual information about the trust fund.',
    `reporting_requirements` STRING COMMENT 'Description of the reporting obligations and transparency requirements for the trust fund to stakeholders.',
    `sustainability_end_date` DATE COMMENT 'The projected date until which the trust fund is expected to remain sustainable based on current balance and disbursement rates.',
    `tax_exempt_status` BOOLEAN COMMENT 'Indicates whether the trust fund has been granted tax-exempt status by relevant authorities.',
    `total_disbursed_amount` DECIMAL(18,2) COMMENT 'Cumulative total amount disbursed from the trust fund since establishment.',
    `trustee_contact_person` STRING COMMENT 'Name of the primary contact person at the trustee organization for fund administration matters.',
    `trustee_email_address` STRING COMMENT 'Primary email address for communication with the trustee organization.',
    `trustee_organization_name` STRING COMMENT 'Name of the organization or entity serving as the trustee responsible for managing the fund.',
    `trustee_phone_number` STRING COMMENT 'Primary contact phone number for the trustee organization.',
    CONSTRAINT pk_beneficiary_trust_fund PRIMARY KEY(`beneficiary_trust_fund_id`)
) COMMENT 'Master reference table for beneficiary_trust_fund. Referenced by beneficiary_trust_fund_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`community`.`land_parcel` (
    `land_parcel_id` BIGINT COMMENT 'Primary key for land_parcel',
    `land_compensation_agreement_id` BIGINT COMMENT 'Reference identifier for the land compensation or benefit-sharing agreement associated with this parcel.',
    `original_land_parcel_id` BIGINT COMMENT 'Self-referencing FK on land_parcel (original_land_parcel_id)',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the land parcel rights including purchase price, compensation, or initial lease payments.',
    `acquisition_date` DATE COMMENT 'Date when the mining company acquired ownership, lease, or license rights to the land parcel.',
    `acquisition_method` STRING COMMENT 'Method or mechanism through which the land parcel rights were acquired by the mining company.',
    `annual_lease_payment` DECIMAL(18,2) COMMENT 'Annual payment amount required under lease or license agreement for ongoing land access rights.',
    `area_hectares` DECIMAL(18,2) COMMENT 'Total area of the land parcel measured in hectares, representing the spatial extent of the parcel boundary.',
    `boundary_description` STRING COMMENT 'Textual description of the land parcel boundaries including metes and bounds or reference to survey plans.',
    `cadastral_lot_number` STRING COMMENT 'Official lot number assigned by the government land registry or cadastral authority for legal land identification.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the land parcel is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the land parcel record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial amounts associated with the land parcel.',
    `environmental_sensitivity` STRING COMMENT 'Classification of the environmental sensitivity or conservation value of the land parcel.',
    `heritage_site_present` BOOLEAN COMMENT 'Indicates whether cultural heritage sites or areas of archaeological significance are present on the land parcel.',
    `households_affected` STRING COMMENT 'Number of households affected by land acquisition or mining operations on this parcel requiring compensation or resettlement.',
    `jurisdiction` STRING COMMENT 'Administrative jurisdiction, state, province, or territory where the land parcel is located and governed.',
    `land_access_restrictions` STRING COMMENT 'Description of any restrictions on land access including seasonal restrictions, cultural protocols, or environmental constraints.',
    `land_use_category` STRING COMMENT 'Primary designated use of the land parcel within the mining operation context.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the land parcel record was most recently updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the land parcel centroid in decimal degrees for spatial reference and mapping.',
    `lease_end_date` DATE COMMENT 'Expiration or termination date of the lease or license agreement, nullable for perpetual or freehold parcels.',
    `lease_start_date` DATE COMMENT 'Effective start date of the lease or license agreement for leased or licensed land parcels.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the land parcel centroid in decimal degrees for spatial reference and mapping.',
    `native_title_status` STRING COMMENT 'Status of native title or indigenous land rights claims over the land parcel.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about the land parcel relevant to community relations and operations.',
    `ownership_status` STRING COMMENT 'Current ownership or control status of the land parcel indicating the legal relationship between the mining company and the land.',
    `parcel_name` STRING COMMENT 'Common name or designation of the land parcel used for business reference and communication.',
    `parcel_reference_number` STRING COMMENT 'External business identifier or cadastral reference number assigned to the land parcel by government land registry or internal tracking system.',
    `parcel_status` STRING COMMENT 'Current lifecycle status of the land parcel in relation to mining operations and community engagement activities.',
    `parcel_type` STRING COMMENT 'Classification of the land parcel based on ownership or tenure type relevant to mining operations.',
    `rehabilitation_bond_amount` DECIMAL(18,2) COMMENT 'Financial bond or security amount held by regulatory authority to ensure land rehabilitation obligations are met.',
    `rehabilitation_obligation` BOOLEAN COMMENT 'Indicates whether the mining company has a legal or contractual obligation to rehabilitate the land parcel after operations cease.',
    `renewal_option_available` BOOLEAN COMMENT 'Indicates whether the lease or license agreement includes an option for renewal upon expiration.',
    `resettlement_required` BOOLEAN COMMENT 'Indicates whether community resettlement or relocation was or will be required for mining operations on this parcel.',
    `survey_date` DATE COMMENT 'Date of the most recent cadastral or boundary survey conducted for the land parcel.',
    `surveyor_name` STRING COMMENT 'Name of the licensed surveyor or survey firm that conducted the most recent land survey.',
    `title_deed_number` STRING COMMENT 'Legal title deed or certificate number registered with the land authority establishing ownership or tenure rights.',
    `traditional_owner_group` STRING COMMENT 'Name of the indigenous or traditional owner group with historical or legal connection to the land parcel.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Current market or assessed valuation of the land parcel for financial reporting and asset management purposes.',
    `valuation_date` DATE COMMENT 'Date when the most recent land valuation was performed.',
    CONSTRAINT pk_land_parcel PRIMARY KEY(`land_parcel_id`)
) COMMENT 'Master reference table for land_parcel. Referenced by original_land_parcel_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ADD CONSTRAINT `fk_community_stakeholder_parent_stakeholder_id` FOREIGN KEY (`parent_stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ADD CONSTRAINT `fk_community_stakeholder_contact_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ADD CONSTRAINT `fk_community_stakeholder_contact_reports_to_stakeholder_contact_id` FOREIGN KEY (`reports_to_stakeholder_contact_id`) REFERENCES `mining_ecm`.`community`.`stakeholder_contact`(`stakeholder_contact_id`);
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ADD CONSTRAINT `fk_community_engagement_plan_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ADD CONSTRAINT `fk_community_engagement_plan_superseded_engagement_plan_id` FOREIGN KEY (`superseded_engagement_plan_id`) REFERENCES `mining_ecm`.`community`.`engagement_plan`(`engagement_plan_id`);
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_engagement_plan_id` FOREIGN KEY (`engagement_plan_id`) REFERENCES `mining_ecm`.`community`.`engagement_plan`(`engagement_plan_id`);
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`meeting` ADD CONSTRAINT `fk_community_meeting_follow_up_meeting_id` FOREIGN KEY (`follow_up_meeting_id`) REFERENCES `mining_ecm`.`community`.`meeting`(`meeting_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance` ADD CONSTRAINT `fk_community_grievance_related_grievance_id` FOREIGN KEY (`related_grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ADD CONSTRAINT `fk_community_grievance_action_preceding_grievance_action_id` FOREIGN KEY (`preceding_grievance_action_id`) REFERENCES `mining_ecm`.`community`.`grievance_action`(`grievance_action_id`);
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ADD CONSTRAINT `fk_community_social_impact_assessment_superseded_social_impact_assessment_id` FOREIGN KEY (`superseded_social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ADD CONSTRAINT `fk_community_land_compensation_agreement_superseded_land_compensation_agreement_id` FOREIGN KEY (`superseded_land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_original_payment_compensation_payment_id` FOREIGN KEY (`original_payment_compensation_payment_id`) REFERENCES `mining_ecm`.`community`.`compensation_payment`(`compensation_payment_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ADD CONSTRAINT `fk_community_compensation_payment_adjusted_compensation_payment_id` FOREIGN KEY (`adjusted_compensation_payment_id`) REFERENCES `mining_ecm`.`community`.`compensation_payment`(`compensation_payment_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_program` ADD CONSTRAINT `fk_community_investment_program_parent_investment_program_id` FOREIGN KEY (`parent_investment_program_id`) REFERENCES `mining_ecm`.`community`.`investment_program`(`investment_program_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_investment_program_id` FOREIGN KEY (`investment_program_id`) REFERENCES `mining_ecm`.`community`.`investment_program`(`investment_program_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`investment_project` ADD CONSTRAINT `fk_community_investment_project_parent_investment_project_id` FOREIGN KEY (`parent_investment_project_id`) REFERENCES `mining_ecm`.`community`.`investment_project`(`investment_project_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ADD CONSTRAINT `fk_community_benefit_sharing_agreement_superseded_benefit_sharing_agreement_id` FOREIGN KEY (`superseded_benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_beneficiary_trust_fund_id` FOREIGN KEY (`beneficiary_trust_fund_id`) REFERENCES `mining_ecm`.`community`.`beneficiary_trust_fund`(`beneficiary_trust_fund_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ADD CONSTRAINT `fk_community_benefit_distribution_prior_benefit_distribution_id` FOREIGN KEY (`prior_benefit_distribution_id`) REFERENCES `mining_ecm`.`community`.`benefit_distribution`(`benefit_distribution_id`);
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ADD CONSTRAINT `fk_community_social_licence_indicator_prior_social_licence_indicator_id` FOREIGN KEY (`prior_social_licence_indicator_id`) REFERENCES `mining_ecm`.`community`.`social_licence_indicator`(`social_licence_indicator_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ADD CONSTRAINT `fk_community_resettlement_plan_superseded_resettlement_plan_id` FOREIGN KEY (`superseded_resettlement_plan_id`) REFERENCES `mining_ecm`.`community`.`resettlement_plan`(`resettlement_plan_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ADD CONSTRAINT `fk_community_resettlement_household_land_parcel_id` FOREIGN KEY (`land_parcel_id`) REFERENCES `mining_ecm`.`community`.`land_parcel`(`land_parcel_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ADD CONSTRAINT `fk_community_resettlement_household_resettlement_plan_id` FOREIGN KEY (`resettlement_plan_id`) REFERENCES `mining_ecm`.`community`.`resettlement_plan`(`resettlement_plan_id`);
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ADD CONSTRAINT `fk_community_resettlement_household_split_from_resettlement_household_id` FOREIGN KEY (`split_from_resettlement_household_id`) REFERENCES `mining_ecm`.`community`.`resettlement_household`(`resettlement_household_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ADD CONSTRAINT `fk_community_local_employment_commitment_superseded_local_employment_commitment_id` FOREIGN KEY (`superseded_local_employment_commitment_id`) REFERENCES `mining_ecm`.`community`.`local_employment_commitment`(`local_employment_commitment_id`);
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ADD CONSTRAINT `fk_community_local_content_actual_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ADD CONSTRAINT `fk_community_local_content_actual_revised_local_content_actual_id` FOREIGN KEY (`revised_local_content_actual_id`) REFERENCES `mining_ecm`.`community`.`local_content_actual`(`local_content_actual_id`);
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ADD CONSTRAINT `fk_community_cultural_heritage_site_parent_cultural_heritage_site_id` FOREIGN KEY (`parent_cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_cultural_heritage_site_id` FOREIGN KEY (`cultural_heritage_site_id`) REFERENCES `mining_ecm`.`community`.`cultural_heritage_site`(`cultural_heritage_site_id`);
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ADD CONSTRAINT `fk_community_heritage_incident_related_heritage_incident_id` FOREIGN KEY (`related_heritage_incident_id`) REFERENCES `mining_ecm`.`community`.`heritage_incident`(`heritage_incident_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`health_program` ADD CONSTRAINT `fk_community_health_program_parent_health_program_id` FOREIGN KEY (`parent_health_program_id`) REFERENCES `mining_ecm`.`community`.`health_program`(`health_program_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_grievance_id` FOREIGN KEY (`grievance_id`) REFERENCES `mining_ecm`.`community`.`grievance`(`grievance_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`security_incident` ADD CONSTRAINT `fk_community_security_incident_related_security_incident_id` FOREIGN KEY (`related_security_incident_id`) REFERENCES `mining_ecm`.`community`.`security_incident`(`security_incident_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ADD CONSTRAINT `fk_community_fpic_process_preceding_fpic_process_id` FOREIGN KEY (`preceding_fpic_process_id`) REFERENCES `mining_ecm`.`community`.`fpic_process`(`fpic_process_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_engagement_plan_id` FOREIGN KEY (`engagement_plan_id`) REFERENCES `mining_ecm`.`community`.`engagement_plan`(`engagement_plan_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_social_impact_assessment_id` FOREIGN KEY (`social_impact_assessment_id`) REFERENCES `mining_ecm`.`community`.`social_impact_assessment`(`social_impact_assessment_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment` ADD CONSTRAINT `fk_community_commitment_parent_commitment_id` FOREIGN KEY (`parent_commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ADD CONSTRAINT `fk_community_commitment_evidence_commitment_id` FOREIGN KEY (`commitment_id`) REFERENCES `mining_ecm`.`community`.`commitment`(`commitment_id`);
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ADD CONSTRAINT `fk_community_commitment_evidence_superseded_commitment_evidence_id` FOREIGN KEY (`superseded_commitment_evidence_id`) REFERENCES `mining_ecm`.`community`.`commitment_evidence`(`commitment_evidence_id`);
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ADD CONSTRAINT `fk_community_stakeholder_engagement_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ADD CONSTRAINT `fk_community_stakeholder_consultation_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ADD CONSTRAINT `fk_community_beneficiary_trust_fund_benefit_sharing_agreement_id` FOREIGN KEY (`benefit_sharing_agreement_id`) REFERENCES `mining_ecm`.`community`.`benefit_sharing_agreement`(`benefit_sharing_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ADD CONSTRAINT `fk_community_beneficiary_trust_fund_stakeholder_id` FOREIGN KEY (`stakeholder_id`) REFERENCES `mining_ecm`.`community`.`stakeholder`(`stakeholder_id`);
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ADD CONSTRAINT `fk_community_beneficiary_trust_fund_parent_beneficiary_trust_fund_id` FOREIGN KEY (`parent_beneficiary_trust_fund_id`) REFERENCES `mining_ecm`.`community`.`beneficiary_trust_fund`(`beneficiary_trust_fund_id`);
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ADD CONSTRAINT `fk_community_land_parcel_land_compensation_agreement_id` FOREIGN KEY (`land_compensation_agreement_id`) REFERENCES `mining_ecm`.`community`.`land_compensation_agreement`(`land_compensation_agreement_id`);
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ADD CONSTRAINT `fk_community_land_parcel_original_land_parcel_id` FOREIGN KEY (`original_land_parcel_id`) REFERENCES `mining_ecm`.`community`.`land_parcel`(`land_parcel_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`community` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `mining_ecm`.`community` SET TAGS ('dbx_domain' = 'community');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Identifier');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `parent_stakeholder_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `benefit_sharing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Arrangement Type');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `benefit_sharing_arrangement` SET TAGS ('dbx_value_regex' = 'none|royalty_payment|employment_quota|infrastructure_investment|community_fund|equity_participation');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `cultural_considerations` SET TAGS ('dbx_business_glossary_term' = 'Cultural Considerations');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `engagement_frequency_required` SET TAGS ('dbx_business_glossary_term' = 'Engagement Frequency Required');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `engagement_frequency_required` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|biannual|annual|ad_hoc');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `fpic_obtained_date` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Obtained Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `fpic_status` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `fpic_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|obtained|withheld');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `grievance_mechanism_registered` SET TAGS ('dbx_business_glossary_term' = 'Grievance Mechanism Registered Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `indigenous_status` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Status Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `influence_level` SET TAGS ('dbx_business_glossary_term' = 'Influence Level');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `influence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `interest_level` SET TAGS ('dbx_business_glossary_term' = 'Interest Level');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `interest_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `land_compensation_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `land_compensation_agreement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|in_negotiation|executed|completed|disputed');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `land_compensation_agreement_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `land_compensation_agreement_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `last_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Engagement Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `media_profile` SET TAGS ('dbx_business_glossary_term' = 'Media Profile Level');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `media_profile` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `next_scheduled_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Engagement Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notes');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `opposition_level` SET TAGS ('dbx_business_glossary_term' = 'Opposition Level');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `opposition_level` SET TAGS ('dbx_value_regex' = 'supportive|neutral|concerned|opposed|actively_opposed');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `postal_address` SET TAGS ('dbx_business_glossary_term' = 'Postal Address');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `postal_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `postal_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `proximity_to_operations_km` SET TAGS ('dbx_business_glossary_term' = 'Proximity to Operations (Kilometers)');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `social_investment_recipient` SET TAGS ('dbx_business_glossary_term' = 'Social Investment Recipient Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `social_licence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Social Licence to Operate (SLO) Risk Rating');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `social_licence_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_category` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Category');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|key|tertiary');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_name` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Name');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_type` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Type');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `stakeholder_type` SET TAGS ('dbx_value_regex' = 'local_community|indigenous_group|landowner|ngo|government_body|advocacy_organisation');
ALTER TABLE `mining_ecm`.`community`.`stakeholder` ALTER COLUMN `traditional_owner_status` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Status Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `stakeholder_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Contact Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Organisation Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `reports_to_stakeholder_contact_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `agreement_signatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signatory Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `authorisation_level` SET TAGS ('dbx_business_glossary_term' = 'Authorisation Level');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `authorisation_level` SET TAGS ('dbx_value_regex' = 'signatory|decision_maker|advisor|representative|observer|none');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `compensation_recipient_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Recipient Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `compensation_recipient_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `consent_to_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent to Contact Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_family_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Family Name');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_given_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Given Name');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|deceased|relocated');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|emergency|technical|legal');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `cultural_protocol_notes` SET TAGS ('dbx_business_glossary_term' = 'Cultural Protocol Notes');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `cultural_protocol_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `employment_status_with_company` SET TAGS ('dbx_business_glossary_term' = 'Employment Status with Company');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `employment_status_with_company` SET TAGS ('dbx_value_regex' = 'current_employee|former_employee|contractor|not_employed');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `engagement_history_summary` SET TAGS ('dbx_business_glossary_term' = 'Engagement History Summary');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `grievance_lodged_flag` SET TAGS ('dbx_business_glossary_term' = 'Grievance Lodged Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `indigenous_status` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `indigenous_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `influence_level` SET TAGS ('dbx_business_glossary_term' = 'Influence Level');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `influence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Contact Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `postal_address` SET TAGS ('dbx_business_glossary_term' = 'Postal Address');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `postal_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `postal_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|in_person|postal_mail');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `preferred_meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Preferred Meeting Location');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `relationship_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength Score');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `role_title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `secondary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `traditional_owner_flag` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Flag');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_contact` ALTER COLUMN `traditional_owner_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `engagement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan ID');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `superseded_engagement_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Approval Date');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `benefit_sharing_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Arrangement');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `benefit_sharing_arrangement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Communication Language');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `cultural_considerations` SET TAGS ('dbx_business_glossary_term' = 'Cultural Considerations');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `engagement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Engagement Frequency');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `engagement_methods` SET TAGS ('dbx_business_glossary_term' = 'Engagement Methods');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `engagement_objectives` SET TAGS ('dbx_business_glossary_term' = 'Engagement Objectives');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `engagement_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Status');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `fpic_process_required` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Process Required Flag');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `grievance_mechanism_linked` SET TAGS ('dbx_business_glossary_term' = 'Grievance Mechanism Linked Flag');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `indigenous_engagement_flag` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Engagement Flag');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `land_compensation_linked` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Linked Flag');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `land_compensation_linked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `land_compensation_linked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Notes');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Code');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^EP-[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Title');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Type');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'strategic|operational|project_specific|issue_response|ongoing|closure');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Frequency');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Risk Level');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `sia_commitment_alignment` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment (SIA) Commitment Alignment');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `sia_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment (SIA) Reference Number');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `success_metrics` SET TAGS ('dbx_business_glossary_term' = 'Success Metrics and Key Performance Indicators (KPIs)');
ALTER TABLE `mining_ecm`.`community`.`engagement_plan` ALTER COLUMN `target_stakeholder_groups` SET TAGS ('dbx_business_glossary_term' = 'Target Stakeholder Groups');
ALTER TABLE `mining_ecm`.`community`.`meeting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`meeting` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Community Meeting ID');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Discussed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `engagement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Group ID');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `follow_up_meeting_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `agenda_summary` SET TAGS ('dbx_business_glossary_term' = 'Agenda Summary');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `commitments_made` SET TAGS ('dbx_business_glossary_term' = 'Commitments Made');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `company_representative_count` SET TAGS ('dbx_business_glossary_term' = 'Company Representative Count');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `consultation_phase` SET TAGS ('dbx_business_glossary_term' = 'Consultation Phase');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `consultation_phase` SET TAGS ('dbx_value_regex' = 'exploration|feasibility|construction|operations|closure|post_closure');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting End Time');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `engagement_topic_category` SET TAGS ('dbx_business_glossary_term' = 'Engagement Topic Category');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `engagement_topic_category` SET TAGS ('dbx_value_regex' = 'environmental|social|economic|health_safety|land_access|resettlement');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `facilitator_organization` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Organization');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `follow_up_action_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Action Status');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `follow_up_action_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Due Date');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `government_official_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Government Official Present Flag');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `grievance_logged_flag` SET TAGS ('dbx_business_glossary_term' = 'Grievance Logged Flag');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `key_issues_raised` SET TAGS ('dbx_business_glossary_term' = 'Key Issues Raised');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `language_used` SET TAGS ('dbx_business_glossary_term' = 'Language Used');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `location_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Location Coordinates');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `location_coordinates` SET TAGS ('dbx_value_regex' = '^-?[0-9]{1,3}.[0-9]{4,10},-?[0-9]{1,3}.[0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `media_present_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Present Flag');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Meeting Status');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_value_regex' = 'public_consultation|focus_group|bilateral|site_visit|town_hall|grievance_hearing');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `minutes_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Minutes Document Reference');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Meeting Notes');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Meeting Reference Number');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `slo_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Social Licence to Operate (SLO) Risk Level');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `slo_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Meeting Start Time');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `translation_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Translation Provided Flag');
ALTER TABLE `mining_ecm`.`community`.`meeting` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`community`.`grievance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`grievance` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance Identifier');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Case Officer Identifier');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Implicated Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `related_grievance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Acknowledgement Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `activity_implicated` SET TAGS ('dbx_business_glossary_term' = 'Mining Activity Implicated');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Case Assignment Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Closure Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `complainant_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Complainant Satisfaction Rating');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `complainant_satisfaction_rating` SET TAGS ('dbx_value_regex' = 'very_satisfied|satisfied|neutral|dissatisfied|very_dissatisfied|not_provided');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'site|regional|corporate|external_mediator|legal');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `grievance_category` SET TAGS ('dbx_business_glossary_term' = 'Grievance Category');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `grievance_description` SET TAGS ('dbx_business_glossary_term' = 'Grievance Description');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Grievance Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `is_repeat_grievance` SET TAGS ('dbx_business_glossary_term' = 'Repeat Grievance Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Grievance Location Description');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `lodgement_channel` SET TAGS ('dbx_business_glossary_term' = 'Grievance Lodgement Channel');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `lodgement_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Lodgement Date');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `lodgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grievance Lodgement Timestamp');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Reference Number');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^GRV-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `requires_external_mediation` SET TAGS ('dbx_business_glossary_term' = 'External Mediation Required Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Outcome');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'resolved_satisfactorily|resolved_partially|unresolved|withdrawn|referred_external|duplicate');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Grievance Severity Classification');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Grievance Subcategory');
ALTER TABLE `mining_ecm`.`community`.`grievance` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `grievance_action_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance Action ID');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Related Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer ID');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance ID');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `preceding_grievance_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_location` SET TAGS ('dbx_business_glossary_term' = 'Action Location');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Action Number');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_business_glossary_term' = 'Action Outcome');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_sequence` SET TAGS ('dbx_business_glossary_term' = 'Action Sequence Number');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Timestamp');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `complainant_acceptance_flag` SET TAGS ('dbx_business_glossary_term' = 'Complainant Acceptance Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `complainant_feedback` SET TAGS ('dbx_business_glossary_term' = 'Complainant Feedback');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `complainant_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Complainant Notification Date');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `complainant_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Complainant Notified Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Action Notes');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Outcome Category');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `outcome_category` SET TAGS ('dbx_value_regex' = 'issue_validated|issue_not_substantiated|partial_resolution|full_resolution|no_resolution|requires_escalation');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `stakeholders_consulted` SET TAGS ('dbx_business_glossary_term' = 'Stakeholders Consulted');
ALTER TABLE `mining_ecm`.`community`.`grievance_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` SET TAGS ('dbx_subdomain' = 'impact_management');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment (SIA) ID');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Assessor Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `resource_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Statement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `superseded_social_impact_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `affected_communities` SET TAGS ('dbx_business_glossary_term' = 'Affected Communities');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Date');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_scope` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_title` SET TAGS ('dbx_business_glossary_term' = 'Assessment Title');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'baseline|impact_assessment|management_plan|monitoring_report|closure_assessment|cumulative_impact');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `baseline_social_conditions` SET TAGS ('dbx_business_glossary_term' = 'Baseline Social Conditions');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `document_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `fpic_status` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Status');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `fpic_status` SET TAGS ('dbx_value_regex' = 'not_applicable|not_started|in_progress|obtained|not_obtained');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `free_prior_informed_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Required');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `impact_significance_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Significance Rating');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `impact_significance_rating` SET TAGS ('dbx_value_regex' = 'negligible|minor|moderate|major|critical');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `indigenous_peoples_involved` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Peoples Involved');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `monitoring_commitments` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Commitments');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `negative_impacts_identified` SET TAGS ('dbx_business_glossary_term' = 'Negative Impacts Identified');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `positive_impacts_identified` SET TAGS ('dbx_business_glossary_term' = 'Positive Impacts Identified');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|approved|conditional_approval|rejected');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `resettlement_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Action Plan (RAP) Reference');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `resettlement_required` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Required');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `review_schedule` SET TAGS ('dbx_business_glossary_term' = 'Review Schedule');
ALTER TABLE `mining_ecm`.`community`.`social_impact_assessment` ALTER COLUMN `stakeholder_engagement_summary` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Summary');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement ID');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Landowner Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement ID');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `superseded_land_compensation_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `agreement_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Agreement Duration (Years)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'surface_access|infrastructure_corridor|temporary_disturbance|permanent_acquisition|easement|right_of_way');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Type');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_value_regex' = 'cash|in_kind|livelihood_restoration|infrastructure|employment|combination');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compensation_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|remediation_required');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `cultural_heritage_provisions` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Provisions');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|under_dispute|mediation|arbitration|litigation|resolved');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `in_kind_description` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Compensation Description');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Land Area (Hectares)');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_parcel_reference` SET TAGS ('dbx_business_glossary_term' = 'Land Parcel Reference');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'agricultural|residential|pastoral|forest|sacred_site|cultural_heritage');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `livelihood_program_details` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Restoration Program Details');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'lump_sum|annual|quarterly|milestone_based|phased');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `rehabilitation_obligations` SET TAGS ('dbx_business_glossary_term' = 'Rehabilitation Obligations');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `total_paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Paid to Date');
ALTER TABLE `mining_ecm`.`community`.`land_compensation_agreement` ALTER COLUMN `total_paid_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `compensation_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Payment Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `compensation_payment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `compensation_payment_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `original_payment_compensation_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `original_payment_compensation_payment_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `original_payment_compensation_payment_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `adjusted_compensation_payment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transfer Reference');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Account Number');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payee_bank_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Branch Code');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payee_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Name');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Failure Reason');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|cash|mobile_money|escrow|direct_deposit');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|processed|completed|failed|cancelled|reversed');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|final|adjustment|arrears|advance');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `receipt_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Confirmation Date');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `receipt_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Confirmation Status');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `receipt_confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|not_received|disputed');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy|under_review');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `mining_ecm`.`community`.`compensation_payment` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `mining_ecm`.`community`.`investment_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`investment_program` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `investment_program_id` SET TAGS ('dbx_business_glossary_term' = 'Community Investment Program ID');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `parent_investment_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `csr_strategy_alignment` SET TAGS ('dbx_business_glossary_term' = 'Corporate Social Responsibility (CSR) Strategy Alignment');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `environmental_impact_consideration` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Consideration');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `estimated_beneficiaries` SET TAGS ('dbx_business_glossary_term' = 'Estimated Beneficiaries');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'corporate_csr|opex|capex|joint_venture|government_partnership|third_party_grant');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_objectives` SET TAGS ('dbx_business_glossary_term' = 'Program Objectives');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|completed|cancelled');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'education|health|infrastructure|livelihood|environment|cultural');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|ad_hoc');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `stakeholder_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Date');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `sustainability_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Indicator');
ALTER TABLE `mining_ecm`.`community`.`investment_program` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `mining_ecm`.`community`.`investment_project` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`investment_project` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `investment_project_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Project ID');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `investment_program_id` SET TAGS ('dbx_business_glossary_term' = 'Community Investment Program ID');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Organisation Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Officer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `parent_investment_project_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `alignment_with_sdg` SET TAGS ('dbx_business_glossary_term' = 'Alignment with Sustainable Development Goals (SDG)');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `deliverables` SET TAGS ('dbx_business_glossary_term' = 'Project Deliverables');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `outcome_indicators` SET TAGS ('dbx_business_glossary_term' = 'Outcome Indicators');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `partnership_type` SET TAGS ('dbx_value_regex' = 'sole|joint_venture|ngo_partnership|government_partnership|community_led');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Project Completion Date');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_scope` SET TAGS ('dbx_business_glossary_term' = 'Project Scope');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|on_hold|completed|cancelled');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `mining_ecm`.`community`.`investment_project` ALTER COLUMN `sustainability_plan` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Plan');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Company Representative Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Land Compensation Agreement ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `ore_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Ore Reserve Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `superseded_benefit_sharing_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Code');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `agreement_code` SET TAGS ('dbx_value_regex' = '^BSA-[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `agreement_title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'royalty_share|employment_quota|local_procurement|infrastructure_contribution|trust_fund|equity_participation');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `benefit_calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benefit Calculation Methodology');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `community_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Community Representative Name');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `community_representative_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `consultation_process_description` SET TAGS ('dbx_business_glossary_term' = 'Consultation Process Description');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `employment_quota_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employment Quota Percentage');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `estimated_beneficiaries_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Beneficiaries Count');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `fpic_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Documentation Reference');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `free_prior_informed_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Obtained');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `governance_structure` SET TAGS ('dbx_business_glossary_term' = 'Governance Structure');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `infrastructure_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Contribution Amount');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `infrastructure_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `legal_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Document Reference');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `local_procurement_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Local Procurement Target Percentage');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|milestone_based|one_time');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `payment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Payment Trigger');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `payment_trigger` SET TAGS ('dbx_value_regex' = 'quarterly|annual|production_milestone|revenue_threshold|project_phase');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `review_schedule` SET TAGS ('dbx_business_glossary_term' = 'Review Schedule');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `review_schedule` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|five_year|milestone_based');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `royalty_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Share Percentage');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `royalty_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `social_licence_to_operate_indicator` SET TAGS ('dbx_business_glossary_term' = 'Social Licence to Operate (SLO) Indicator');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `trust_fund_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Trust Fund Contribution Amount');
ALTER TABLE `mining_ecm`.`community`.`benefit_sharing_agreement` ALTER COLUMN `trust_fund_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `benefit_distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Distribution ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `beneficiary_trust_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Trust Fund ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `performance_actual_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Performance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Community ID');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `prior_benefit_distribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `authorisation_date` SET TAGS ('dbx_business_glossary_term' = 'Authorisation Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `authorisation_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorisation Reference');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `authorised_by` SET TAGS ('dbx_business_glossary_term' = 'Authorised By');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'direct_payment|community_investment|capacity_building|infrastructure|compensation|other');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `calculation_period_production_volume` SET TAGS ('dbx_business_glossary_term' = 'Calculation Period Production Volume');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `calculation_period_revenue` SET TAGS ('dbx_business_glossary_term' = 'Calculation Period Revenue');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `calculation_period_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `dispute_raised` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `dispute_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `distribution_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Reference Number');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `distribution_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'planned|approved|disbursed|confirmed|disputed|cancelled');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `in_kind_description` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Benefit Description');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `monetary_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value Amount');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Notes');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `production_volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Production Volume Unit of Measure');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `production_volume_unit` SET TAGS ('dbx_value_regex' = 'tonnes|kilograms|ounces|pounds|cubic_metres|other');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `receipt_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Confirmation Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `receipt_confirmation_received` SET TAGS ('dbx_business_glossary_term' = 'Receipt Confirmation Received');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `receipt_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Receipt Document Reference');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`community`.`benefit_distribution` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `social_licence_indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Social Licence Indicator ID');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `prior_social_licence_indicator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `action_required` SET TAGS ('dbx_business_glossary_term' = 'Action Required');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `affected_communities` SET TAGS ('dbx_business_glossary_term' = 'Affected Communities');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `assessor_organisation` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organisation');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_business_glossary_term' = 'Indicator Category');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_value_regex' = 'perception|behaviour|outcome|impact');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `indicator_type` SET TAGS ('dbx_business_glossary_term' = 'Social Licence to Operate (SLO) Indicator Type');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `indicator_type` SET TAGS ('dbx_value_regex' = 'trust_level|acceptance_level|approval_level|grievance_rate|engagement_participation_rate|community_sentiment');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `indigenous_peoples_included` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Peoples Included');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `key_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Findings Summary');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `margin_of_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Margin of Error Percentage');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|ad_hoc');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'survey|focus_group|third_party_assessment|community_meeting|stakeholder_interview|media_analysis');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `next_measurement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Measurement Due Date');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `previous_period_score` SET TAGS ('dbx_business_glossary_term' = 'Previous Period Score');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Indicator Rating');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Percentage');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Indicator Score');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `score_scale_maximum` SET TAGS ('dbx_business_glossary_term' = 'Score Scale Maximum');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `score_scale_minimum` SET TAGS ('dbx_business_glossary_term' = 'Score Scale Minimum');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `stakeholder_groups_included` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Groups Included');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `target_score` SET TAGS ('dbx_business_glossary_term' = 'Target Score');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `third_party_verified` SET TAGS ('dbx_business_glossary_term' = 'Third Party Verified');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|declining|not_applicable');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `variance_from_previous_period` SET TAGS ('dbx_business_glossary_term' = 'Variance from Previous Period');
ALTER TABLE `mining_ecm`.`community`.`social_licence_indicator` ALTER COLUMN `variance_from_target` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` SET TAGS ('dbx_subdomain' = 'impact_management');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `resettlement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Plan ID');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Consultant Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Consultant Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment (SIA) ID');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `superseded_resettlement_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `affected_households_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Households Count');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `affected_persons_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Persons Count');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `approval_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Name');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_framework` SET TAGS ('dbx_business_glossary_term' = 'Compensation Framework');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_framework` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `compensation_framework` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `fpic_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Required Flag');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `fpic_status` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `fpic_status` SET TAGS ('dbx_value_regex' = 'not required|consultation in progress|consent obtained|consent withheld');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `grievance_mechanism_reference` SET TAGS ('dbx_business_glossary_term' = 'Grievance Mechanism Reference');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `ifc_ps5_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'IFC PS5 Compliance Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `ifc_ps5_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|under assessment|not applicable');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `indigenous_peoples_affected_flag` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Peoples Affected Flag');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `land_area_acquired_hectares` SET TAGS ('dbx_business_glossary_term' = 'Land Area Acquired (Hectares)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `livelihood_restoration_strategy` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Restoration Strategy');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `next_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `plan_document_location` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Location');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Reference Number');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `plan_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Plan Title');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|under review|approved|conditionally approved|rejected|resubmission required');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `resettlement_site_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Site Coordinates');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `resettlement_site_location` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Site Location');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `resettlement_site_name` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Site Name');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `resettlement_type` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Type');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `resettlement_type` SET TAGS ('dbx_value_regex' = 'physical relocation|economic displacement|combined physical and economic');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `stakeholder_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `total_compensation_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Budget Amount');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `total_compensation_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` SET TAGS ('dbx_subdomain' = 'impact_management');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `resettlement_household_id` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Household Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `land_parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Original Land Parcel Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `resettlement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Program Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `split_from_resettlement_household_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `allocated_land_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Allocated Land Area in Hectares');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `allocated_plot_number` SET TAGS ('dbx_business_glossary_term' = 'Allocated Plot Number');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `asset_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Asset Inventory Value');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `baseline_annual_income` SET TAGS ('dbx_business_glossary_term' = 'Baseline Annual Income');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `baseline_annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Compensation Amount');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `cash_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `census_date` SET TAGS ('dbx_business_glossary_term' = 'Census Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Compensation Payment Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_date` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Payment Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_status` SET TAGS ('dbx_value_regex' = 'pending|partial|completed|disputed|withheld');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `compensation_payment_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending_verification|disputed');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `entitlement_category` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Category');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `entitlement_category` SET TAGS ('dbx_value_regex' = 'land_for_land|cash_compensation|replacement_housing|livelihood_support|combination');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `grievance_lodged_flag` SET TAGS ('dbx_business_glossary_term' = 'Grievance Lodged Flag');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `grievance_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `grievance_resolution_status` SET TAGS ('dbx_value_regex' = 'no_grievance|open|under_review|resolved|escalated');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_head_name` SET TAGS ('dbx_business_glossary_term' = 'Household Head Full Name');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_head_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_head_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_head_national_identifier` SET TAGS ('dbx_business_glossary_term' = 'Household Head National Identification (ID) Number');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_head_national_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_head_national_identifier` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Household Reference Number');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `income_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Income Currency Code');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `income_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `indigenous_household_flag` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Household Flag');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `land_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Land Area in Hectares');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `land_tenure_type` SET TAGS ('dbx_business_glossary_term' = 'Land Tenure Type');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `land_tenure_type` SET TAGS ('dbx_value_regex' = 'legal_owner|customary_owner|tenant|squatter|sharecropper|communal');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `last_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `livelihood_restoration_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Livelihood Restoration Plan Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `livelihood_restoration_plan_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_required');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `monitoring_phase` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Phase');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `monitoring_phase` SET TAGS ('dbx_value_regex' = 'baseline|transition|post_relocation_year_1|post_relocation_year_2|post_relocation_year_3|completed');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `original_address` SET TAGS ('dbx_business_glossary_term' = 'Original Residential Address');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `original_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `original_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `original_village_name` SET TAGS ('dbx_business_glossary_term' = 'Original Village Name');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `primary_livelihood_source` SET TAGS ('dbx_business_glossary_term' = 'Primary Livelihood Source');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `relocation_date` SET TAGS ('dbx_business_glossary_term' = 'Relocation Date');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `relocation_status` SET TAGS ('dbx_business_glossary_term' = 'Relocation Status');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `relocation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|refused|deferred');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `resettlement_site_name` SET TAGS ('dbx_business_glossary_term' = 'Resettlement Site Name');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `structure_replacement_value` SET TAGS ('dbx_business_glossary_term' = 'Structure Replacement Value');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `structure_type` SET TAGS ('dbx_business_glossary_term' = 'Structure Type');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `structure_type` SET TAGS ('dbx_value_regex' = 'permanent|semi_permanent|temporary|traditional');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `total_entitlement_value` SET TAGS ('dbx_business_glossary_term' = 'Total Entitlement Value');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `total_entitlement_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_value_regex' = 'female_headed|elderly|disabled|child_headed|extreme_poverty|multiple_vulnerabilities');
ALTER TABLE `mining_ecm`.`community`.`resettlement_household` ALTER COLUMN `vulnerable_household_flag` SET TAGS ('dbx_business_glossary_term' = 'Vulnerable Household Flag');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `local_employment_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Local Employment Commitment Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `superseded_local_employment_commitment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_description` SET TAGS ('dbx_business_glossary_term' = 'Commitment Description');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Effective Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Expiry Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_reference` SET TAGS ('dbx_business_glossary_term' = 'Commitment Reference Number');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|achieved|not_met|closed');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'employment_percentage|apprenticeship_quota|local_supplier_spend|training_program|graduate_program|indigenous_employment');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `fpic_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Required Flag');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `fpic_status` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Status');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `fpic_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|obtained|not_obtained');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `indigenous_peoples_flag` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Peoples Flag');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `performance_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Variance Percentage');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `regulatory_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Flag');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `social_licence_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Social Licence to Operate (SLO) Risk Level');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `social_licence_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `stakeholder_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Date');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `mining_ecm`.`community`.`local_employment_commitment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'percentage|headcount|currency|hours');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `local_content_actual_id` SET TAGS ('dbx_business_glossary_term' = 'Local Content Actual ID');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment ID');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `revised_local_content_actual_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `actual_local_employment_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Local Employment Headcount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `actual_local_supplier_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Local Supplier Spend Amount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|partial|under-review|exempt');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `employment_variance_headcount` SET TAGS ('dbx_business_glossary_term' = 'Employment Variance Headcount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `employment_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Employment Variance Percentage');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `local_employment_percentage_achieved` SET TAGS ('dbx_business_glossary_term' = 'Local Employment Percentage Achieved');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `local_spend_percentage_achieved` SET TAGS ('dbx_business_glossary_term' = 'Local Spend Percentage Achieved');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `spend_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Variance Amount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `spend_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Spend Variance Percentage');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `target_local_employment_headcount` SET TAGS ('dbx_business_glossary_term' = 'Target Local Employment Headcount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `target_local_employment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Local Employment Percentage');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `target_local_spend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Local Spend Percentage');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `target_local_supplier_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Local Supplier Spend Amount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `total_procurement_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Procurement Spend Amount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `total_workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Total Workforce Headcount');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'internal-audit|external-audit|self-reported|third-party-verified|regulatory-inspection');
ALTER TABLE `mining_ecm`.`community`.`local_content_actual` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` SET TAGS ('dbx_subdomain' = 'impact_management');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `cultural_heritage_site_id` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Site ID');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Tenement ID');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `parent_cultural_heritage_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `access_protocol` SET TAGS ('dbx_business_glossary_term' = 'Site Access Protocol');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Heritage Information Confidentiality Level');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `coordinate_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Accuracy (Meters)');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `coordinate_datum` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Datum');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `cultural_group_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Cultural Group Affiliation');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `cultural_group_affiliation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Discovery Date');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Heritage Documentation Location');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `fpic_date` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Date');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `fpic_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Prior and Informed Consent (FPIC) Obtained Flag');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `heritage_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Heritage Agreement Reference');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `heritage_survey_reference` SET TAGS ('dbx_business_glossary_term' = 'Heritage Survey Reference');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Site Latitude');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Site Longitude');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `management_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Heritage Management Restrictions');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `no_go_zone_radius_meters` SET TAGS ('dbx_business_glossary_term' = 'No-Go Zone Radius (Meters)');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Notes');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `protection_status` SET TAGS ('dbx_business_glossary_term' = 'Heritage Protection Status');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `protection_status` SET TAGS ('dbx_value_regex' = 'statutory protected|registered|no-go zone|conditional access|under review|unprotected');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Registration Date');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `regulatory_listing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Heritage Listing Reference');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `significance_description` SET TAGS ('dbx_business_glossary_term' = 'Cultural Significance Description');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `significance_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_area_hectares` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Area (Hectares)');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_condition` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Condition');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_condition` SET TAGS ('dbx_value_regex' = 'intact|partially disturbed|significantly disturbed|damaged|destroyed');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Name');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Site Reference Number');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Status');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Type');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Heritage Survey Date');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_business_glossary_term' = 'Heritage Surveyor Name');
ALTER TABLE `mining_ecm`.`community`.`cultural_heritage_site` ALTER COLUMN `surveyor_organisation` SET TAGS ('dbx_business_glossary_term' = 'Heritage Surveyor Organisation');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `heritage_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Incident Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `cultural_heritage_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `related_heritage_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `area_impacted_hectares` SET TAGS ('dbx_business_glossary_term' = 'Area Impacted (Hectares)');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `artefacts_disturbed_count` SET TAGS ('dbx_business_glossary_term' = 'Artefacts Disturbed Count');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `heritage_site_name` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Name');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `heritage_site_reference` SET TAGS ('dbx_business_glossary_term' = 'Heritage Site Reference');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `heritage_type` SET TAGS ('dbx_business_glossary_term' = 'Heritage Type');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|remediation_in_progress|remediation_complete|closed');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|on_hold');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `location_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Location Coordinates');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `regulator_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulator Notification Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `regulator_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulator Notified Flag');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `remediation_measures` SET TAGS ('dbx_business_glossary_term' = 'Remediation Measures');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|planned|in_progress|complete|not_required');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'minor|moderate|major|critical|catastrophic');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `traditional_owner_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Notification Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `traditional_owner_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Traditional Owner Notified Flag');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `work_stoppage_date` SET TAGS ('dbx_business_glossary_term' = 'Work Stoppage Date');
ALTER TABLE `mining_ecm`.`community`.`heritage_incident` ALTER COLUMN `work_stoppage_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Stoppage Issued Flag');
ALTER TABLE `mining_ecm`.`community`.`health_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`health_program` SET TAGS ('dbx_subdomain' = 'impact_management');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_program_id` SET TAGS ('dbx_business_glossary_term' = 'Community Health Program ID');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_program_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_program_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Target Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `parent_health_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `actual_beneficiaries_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Beneficiaries Count');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `environmental_health_linkage` SET TAGS ('dbx_business_glossary_term' = 'Environmental Health Linkage');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `environmental_health_linkage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `environmental_health_linkage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'company_csr|benefit_sharing_agreement|government_grant|donor_contribution|joint_funding');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Health Focus Area');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_focus_area` SET TAGS ('dbx_value_regex' = 'malaria|hiv_aids|nutrition|maternal_health|mental_health|water_sanitation');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_focus_area` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `health_focus_area` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `ifc_ps4_alignment` SET TAGS ('dbx_business_glossary_term' = 'IFC Performance Standard 4 (PS4) Alignment');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `key_performance_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPI)');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'ngo|government|healthcare_provider|community_organization|international_agency');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_objectives` SET TAGS ('dbx_business_glossary_term' = 'Program Objectives');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'planned|active|suspended|completed|cancelled');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|biannual|annual');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `stakeholder_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Date');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `sustainability_plan` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Plan');
ALTER TABLE `mining_ecm`.`community`.`health_program` ALTER COLUMN `target_beneficiaries_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiaries Count');
ALTER TABLE `mining_ecm`.`community`.`security_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`security_incident` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigating Officer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Involved Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `related_security_incident_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Closure Date');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `community_area_flag` SET TAGS ('dbx_business_glossary_term' = 'Community Area Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `community_member_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Community Member Involved Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `fatalities_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Fatalities Reported Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `grievance_lodged_flag` SET TAGS ('dbx_business_glossary_term' = 'Grievance Lodged Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|resolved|closed|escalated|pending');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Type');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'illegal_mining|trespass|theft|civil_unrest|security_force_interaction|vandalism');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `injuries_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Injuries Reported Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|critical');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Reference');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `law_enforcement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `location_coordinates` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Coordinates');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `loss_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency Code');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `loss_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `media_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Media Coverage Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `number_of_fatalities` SET TAGS ('dbx_business_glossary_term' = 'Number of Fatalities');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `number_of_individuals_involved` SET TAGS ('dbx_business_glossary_term' = 'Number of Individuals Involved');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `number_of_injuries` SET TAGS ('dbx_business_glossary_term' = 'Number of Injuries');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `parties_involved` SET TAGS ('dbx_business_glossary_term' = 'Parties Involved');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `parties_involved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `property_damage_description` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Description');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `property_damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Reference');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_business_glossary_term' = 'Reported By Name');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `reported_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `reported_by_role` SET TAGS ('dbx_business_glossary_term' = 'Reported By Role');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `security_force_type` SET TAGS ('dbx_business_glossary_term' = 'Security Force Type');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `security_force_type` SET TAGS ('dbx_value_regex' = 'private_security|public_security|mine_security|joint_response');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `security_response_description` SET TAGS ('dbx_business_glossary_term' = 'Security Response Description');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `slo_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Social Licence to Operate (SLO) Risk Level');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `slo_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `use_of_force_description` SET TAGS ('dbx_business_glossary_term' = 'Use of Force Description');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `use_of_force_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `use_of_force_flag` SET TAGS ('dbx_business_glossary_term' = 'Use of Force Flag');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `vpshr_assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Principles on Security and Human Rights (VPSHR) Assessment Notes');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `vpshr_compliance_assessment` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Principles on Security and Human Rights (VPSHR) Compliance Assessment');
ALTER TABLE `mining_ecm`.`community`.`security_incident` ALTER COLUMN `vpshr_compliance_assessment` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `fpic_process_id` SET TAGS ('dbx_business_glossary_term' = 'Free, Prior and Informed Consent (FPIC) Process ID');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Licence Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Indigenous Group Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site ID');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement ID');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `preceding_fpic_process_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `activity_requiring_consent` SET TAGS ('dbx_business_glossary_term' = 'Activity Requiring Consent');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'exploration|mine_development|extraction|infrastructure|closure|expansion');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `authorised_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorised Signatory Name');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `authorised_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `authorised_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorised Signatory Title');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `conditions_attached_to_consent` SET TAGS ('dbx_business_glossary_term' = 'Conditions Attached to Consent');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `consent_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Decision Date');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'consent_given|consent_withheld|ongoing_negotiation|process_initiated|suspended|withdrawn');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `consultation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Consultation Completion Date');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `consultation_process_description` SET TAGS ('dbx_business_glossary_term' = 'Consultation Process Description');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `cultural_heritage_provisions` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Provisions');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `document_location` SET TAGS ('dbx_business_glossary_term' = 'Document Location');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `grievance_mechanism_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Grievance Mechanism Linked Flag');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `independent_facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Independent Facilitator Name');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `information_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Information Disclosure Date');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `interpreter_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Provided Flag');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `language_used` SET TAGS ('dbx_business_glossary_term' = 'Language Used');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `legal_review_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `process_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Process Initiation Date');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `process_reference_number` SET TAGS ('dbx_business_glossary_term' = 'FPIC Process Reference Number');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `process_reference_number` SET TAGS ('dbx_value_regex' = '^FPIC-[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `review_trigger_conditions` SET TAGS ('dbx_business_glossary_term' = 'Review Trigger Conditions');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `sia_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment (SIA) Reference Number');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `traditional_territory_name` SET TAGS ('dbx_business_glossary_term' = 'Traditional Territory Name');
ALTER TABLE `mining_ecm`.`community`.`fpic_process` ALTER COLUMN `traditional_territory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`commitment` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Community Commitment Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `benefit_sharing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Sharing Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `engagement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Land Compensation Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `parent_commitment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Approval Date');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_category` SET TAGS ('dbx_business_glossary_term' = 'Commitment Category');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_category` SET TAGS ('dbx_value_regex' = 'regulatory|contractual|voluntary|public_statement');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_description` SET TAGS ('dbx_business_glossary_term' = 'Commitment Description');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_source` SET TAGS ('dbx_business_glossary_term' = 'Commitment Source');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Completion Date');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commitment Completion Percentage');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Due Date');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `evidence_document_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Location');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `evidence_of_fulfilment` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Fulfilment');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Commitment Review Date');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Commitment Priority Level');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Reference Number');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `regulatory_condition_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Reference');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|ad_hoc|not_required');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `reporting_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation Flag');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `reporting_recipient` SET TAGS ('dbx_business_glossary_term' = 'Reporting Recipient');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Review Date');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Commitment Risk Level');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'very_high|high|medium|low|very_low');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `sia_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment (SIA) Reference Number');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `stakeholder_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Acceptance Status');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `stakeholder_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|pending|disputed|not_applicable');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `stakeholder_feedback` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Feedback');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `target_community` SET TAGS ('dbx_business_glossary_term' = 'Target Community');
ALTER TABLE `mining_ecm`.`community`.`commitment` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Commitment Title');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `commitment_evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Commitment Evidence Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Community Commitment Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `primary_commitment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter User Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `primary_commitment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `primary_commitment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `superseded_commitment_evidence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Confidentiality Level');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Location');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `document_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Document Size in Megabytes (MB)');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Period End Date');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Period Start Date');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference Number');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Verification Status');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|verified|rejected|pending_clarification|archived');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'report|photo|video|third_party_verification|audit_finding|inspection_certificate');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `lender_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Lender Reporting Flag');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Evidence Rejection Reason');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `stakeholder_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Date');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `stakeholder_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Notification Required Flag');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Date');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Timestamp');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `submitted_by_department` SET TAGS ('dbx_business_glossary_term' = 'Submitter Department');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `submitted_by_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Full Name');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `submitted_by_role` SET TAGS ('dbx_business_glossary_term' = 'Submitter Role Title');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `third_party_verifier_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Third Party Verifier Accreditation');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `third_party_verifier_organisation` SET TAGS ('dbx_business_glossary_term' = 'Third Party Verifier Organisation');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Verification Date');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'desktop_review|site_inspection|stakeholder_interview|third_party_audit|document_analysis');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partially_accepted|requires_additional_evidence');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Full Name');
ALTER TABLE `mining_ecm`.`community`.`commitment_evidence` ALTER COLUMN `verifier_role` SET TAGS ('dbx_business_glossary_term' = 'Verifier Role Title');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` SET TAGS ('dbx_association_edges' = 'workforce.employee,community.stakeholder');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `stakeholder_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Identifier');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement - Employee Id');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement - Stakeholder Id');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `designation_authority` SET TAGS ('dbx_business_glossary_term' = 'Designation Authority');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Relationship Type');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_engagement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` SET TAGS ('dbx_subdomain' = 'stakeholder_relations');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` SET TAGS ('dbx_association_edges' = 'mine.lom_plan,community.stakeholder');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `stakeholder_consultation_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Identifier');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation - Lom Plan Id');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation - Stakeholder Id');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `consultation_conducted_by` SET TAGS ('dbx_business_glossary_term' = 'Consultation Conducted By');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Consultation Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `consultation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Consultation Outcome');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `engagement_phase` SET TAGS ('dbx_business_glossary_term' = 'Engagement Phase');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `next_consultation_required_date` SET TAGS ('dbx_business_glossary_term' = 'Next Consultation Required Date');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `regulatory_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Met');
ALTER TABLE `mining_ecm`.`community`.`stakeholder_consultation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `beneficiary_trust_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Trust Fund Identifier');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `parent_beneficiary_trust_fund_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `trustee_contact_person` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `trustee_contact_person` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `trustee_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `trustee_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `trustee_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`community`.`beneficiary_trust_fund` ALTER COLUMN `trustee_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` SET TAGS ('dbx_subdomain' = 'benefit_distribution');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `land_parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Land Parcel Identifier');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `land_compensation_agreement_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `original_land_parcel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `annual_lease_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `households_affected` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `rehabilitation_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `title_deed_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `traditional_owner_group` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`community`.`land_parcel` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
