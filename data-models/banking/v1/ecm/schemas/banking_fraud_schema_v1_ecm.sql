-- Schema for Domain: fraud | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`fraud` COMMENT 'Operational fraud case management covering fraud detection alerts, investigation workflows, case disposition, chargeback management, loss recovery, and SAR escalation. Manages fraud typologies, rule configurations, and case outcomes for retail, card, and wire fraud. Distinct from compliance AML monitoring.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for case',
    `deposit_account_id` BIGINT COMMENT 'Reference to the deposit or loan account involved in the fraud incident. Nullable for party-level fraud cases without specific account context.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud cases document the channel where fraud was perpetrated. Required for SAR filings (FinCEN requires channel context), Basel II operational risk reporting, channel security investment decisions, an',
    `employee_id` BIGINT COMMENT 'Reference to the fraud investigator or analyst assigned to work this case. Links to employee or user master data.',
    `case_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified this case record. Used for audit trail and accountability.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key linking to channel.relationship_manager. Business justification: Fraud cases involving relationship-managed clients (commercial banking, wealth management) are assigned to RMs for customer communication, reputational risk management, relationship retention, and coo',
    `contact_center_id` BIGINT COMMENT 'Foreign key linking to channel.contact_center. Business justification: Fraud cases reported via contact centers need linkage for quality assurance, call recording retrieval (legal evidence for litigation/arbitration), contact center fraud training, and regulatory exam su',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this case. Supports multi-currency fraud operations.',
    `journey_id` BIGINT COMMENT 'Foreign key linking to channel.journey. Business justification: Fraud occurring during customer journeys (account opening, loan application, product enrollment) requires journey context for fraud typology classification (application fraud vs. transaction fraud), j',
    `fraud_alert_id` BIGINT COMMENT 'Reference to the originating fraud detection alert that triggered this case. Links to alert management system for detection effectiveness analysis.',
    `fraud_ring_id` BIGINT COMMENT 'Identifier linking this case to a known fraud ring or organized crime group. Nullable if not part of a ring.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Fraud cases involving securities (insider trading, market abuse, unauthorized securities transactions) need instrument reference for case management, regulatory filings (SAR with securities context), ',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Complex fraud cases may require branch-based investigation (safe deposit box fraud, teller collusion, check fraud, cash vault discrepancies). Links case to physical location for evidence collection, s',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Fraud cases frequently involve investor accounts (unauthorized redemptions, identity theft in fund transactions, forged instructions). Fraud operations teams need direct linkage to investigate and res',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Fraud cases are operational risk events under Basel II/III event types External Fraud (ET6) and Internal Fraud (ET7). Required for regulatory capital calculation under AMA/SMA approaches and Pilla',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud cases originate from specific customer interactions. Linking provides forensic detail (employee involved, transaction amount, override codes, authentication method) for investigations, employee ',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud cases often originate from specific customer sessions. Session data provides forensic evidence (IP, device, geolocation, user actions, authentication method) required for investigations, SAR nar',
    `party_id` BIGINT COMMENT 'Reference to the customer or party entity that is the subject of the fraud investigation. Links to customer master data.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each case can be classified by a fraud typology. N:1 relationship. No bidirectional conflict (typology does not have case_id FK back). Note: fraud_detection_method is different from typology classific',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the case was assigned to an investigator. Used for SLA tracking and workload analytics.',
    `case_number` STRING COMMENT 'Externally visible unique case reference number assigned at case creation. Used for customer communication and cross-system tracking.. Valid values are `^FC-[0-9]{8,12}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the fraud case. Drives workflow routing and SLA monitoring.. Valid values are `new|assigned|under_investigation|pending_review|closed|escalated`',
    `case_type` STRING COMMENT 'Classification of fraud case by fraud typology. Determines investigation workflow and regulatory reporting requirements.. Valid values are `card_fraud|wire_fraud|ach_fraud|check_fraud|identity_theft|account_takeover`',
    `chargeback_initiated_flag` BOOLEAN COMMENT 'Indicates whether a chargeback was initiated with the card network or payment processor for loss recovery.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the case was closed. Nullable for open cases. Used for cycle time and resolution metrics.',
    `confirmed_loss_amount` DECIMAL(18,2) COMMENT 'Final confirmed financial loss amount after investigation completion. Used for regulatory reporting and loss provisioning. Expressed in base currency.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this case record was first created in the database. Used for audit trail and data lineage.',
    `customer_reimbursed_flag` BOOLEAN COMMENT 'Indicates whether the affected customer was reimbursed for their loss. Used for customer satisfaction and regulatory compliance tracking.',
    `disposition_outcome` STRING COMMENT 'Final investigation outcome classification. Determines customer remediation, regulatory reporting, and fraud analytics.. Valid values are `confirmed_fraud|false_positive|customer_error|insufficient_evidence|referred_law_enforcement`',
    `disposition_reason` STRING COMMENT 'Detailed narrative explanation of the disposition outcome. Captures investigator findings and supporting rationale.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Initial estimated financial loss amount at case opening. May be revised during investigation. Expressed in base currency.',
    `fraud_detection_method` STRING COMMENT 'The method or system that initially detected the fraud. Used to measure detection effectiveness and optimize fraud controls.. Valid values are `rule_based|ml_model|customer_report|manual_review|third_party_alert`',
    `fraud_ring_indicator` BOOLEAN COMMENT 'Indicates whether this case is part of an identified organized fraud ring or syndicate. Used for pattern analysis and network investigation.',
    `insurance_claim_filed_flag` BOOLEAN COMMENT 'Indicates whether an insurance claim was filed for fraud loss recovery under the banks fraud insurance policy.',
    `investigation_notes` STRING COMMENT 'Free-text field capturing investigator observations, findings, and case narrative. Confidential investigative work product.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the case was referred. Nullable if no referral was made.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was referred to law enforcement agencies for criminal investigation or prosecution.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was initially opened in the case management system. Marks the start of the investigation lifecycle.',
    `priority` STRING COMMENT 'Business priority level assigned based on loss amount, customer segment, and fraud severity. Determines investigation resource allocation.. Valid values are `critical|high|medium|low`',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total amount recovered through chargeback, insurance claim, or legal action. Used to calculate net loss. Expressed in base currency.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this case requires regulatory reporting beyond SAR filing, such as Currency Transaction Report (CTR) or other jurisdiction-specific filings.',
    `reimbursement_amount` DECIMAL(18,2) COMMENT 'Total amount reimbursed to the customer. Nullable if no reimbursement was made. Expressed in base currency.',
    `reimbursement_date` DATE COMMENT 'Date when the customer reimbursement was processed. Nullable if no reimbursement was made. Used for SLA compliance tracking.',
    `related_case_count` STRING COMMENT 'Number of related fraud cases linked to this case through common attributes such as party, device, or transaction pattern.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN for this case. Critical for regulatory compliance tracking.',
    `sar_filing_date` DATE COMMENT 'Date when the SAR was filed with FinCEN. Nullable if no SAR was filed. Used for regulatory deadline compliance monitoring.',
    `severity` STRING COMMENT 'Risk-based severity classification reflecting potential financial and reputational impact. Level 1 is highest severity.. Valid values are `level_1|level_2|level_3|level_4`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the case exceeded defined SLA thresholds for investigation or resolution time. Used for operational performance monitoring.',
    `sla_target_close_date` DATE COMMENT 'Target date by which the case should be closed based on SLA policy and case priority. Used for workload planning and escalation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this case record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Core master entity representing an operational fraud case opened against a customer, account, or transaction. Captures the full lifecycle from initial alert escalation through investigation, disposition, and closure. Key attributes include case type (card fraud, wire fraud, identity theft, account takeover, check fraud), case status and status history, assigned investigator, priority/severity, channel of occurrence, estimated and confirmed loss amounts, recovery amount, disposition outcome, and regulatory escalation flags. Serves as the central hub linking alerts, incidents, investigations, chargebacks, claims, SARs, evidence, and loss records. Managed within NICE Actimize or Oracle Financial Crime case management platforms.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`fraud_alert` (
    `fraud_alert_id` BIGINT COMMENT 'Unique identifier for the fraud alert record. Primary key.',
    `account_transaction_id` BIGINT COMMENT 'Identifier of the triggering transaction or event that caused the fraud alert to be generated. Links to the underlying payment, transfer, or account activity.',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: Fraud alerts for ATM transactions must link to the specific ATM for forensic analysis (camera footage retrieval, cash cassette reconciliation, skimming device inspection), ATM network fraud pattern an',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key linking to channel.relationship_manager. Business justification: High-value customer fraud alerts are escalated to relationship managers for customer notification and relationship preservation. Links enable white-glove fraud resolution for private banking/wealth ma',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Unique identifier of the deposit account, loan account, or card account involved in the fraud alert.',
    `detection_rule_id` BIGINT COMMENT 'Identifier of the specific fraud detection rule or model that triggered this alert. Used for rule performance tracking and tuning.',
    `device_fingerprint_id` BIGINT COMMENT 'Unique identifier of the device (computer, mobile phone, tablet) used to initiate the transaction, captured via device fingerprinting technology.',
    `digital_channel_id` BIGINT COMMENT 'Foreign key linking to channel.digital_channel. Business justification: When fraud occurs via digital channels (mobile app, online banking, API), linking to digital_channel enables analysis of platform-specific vulnerabilities, API abuse patterns, PSD2/open banking fraud ',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or investigator assigned to review and disposition the alert.',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Fraud alerts are triggered by suspicious fund transactions (unusual redemption patterns, rapid switching, structuring). AML and fraud monitoring systems generate alerts on specific fund transactions r',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Alerts capture transaction origin country for geographic risk assessment, sanctions screening (OFAC), cross-border fraud detection, and AML risk rating. Essential for fraud and AML operations. New FK ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities fraud alerts (pump-and-dump schemes, market manipulation, unauthorized trading) require direct instrument linkage for trading surveillance, regulatory reporting (MAR/MiFID II), and investig',
    `journey_id` BIGINT COMMENT 'Foreign key linking to channel.journey. Business justification: Fraud alerts triggered during customer journeys enable journey-stage-specific fraud controls (enhanced KYC at onboarding, transaction limits during first 30 days), journey optimization (reducing frict',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Real-time fraud detection systems monitor wealth portfolios for unusual trading patterns, large withdrawals, or unauthorized access. Alerts require portfolio context for risk scoring and investigation',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Alerts link merchant categories to industry risk profiles for fraud typology detection, high-risk MCC flagging, and rule tuning. Essential for card fraud detection. New FK replaces denormalized MCC co',
    `party_id` BIGINT COMMENT 'Unique identifier of the customer or party associated with the account or transaction that triggered the fraud alert.',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud alerts triggered during active sessions need session context for investigation (page flow, transaction sequence, authentication events). Critical for real-time fraud intervention, step-up authen',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud alerts capture the channel where suspicious transactions occurred for pattern analysis and channel-specific fraud detection tuning. Essential for fraud operations teams analyzing fraud by channe',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud alerts are triggered by specific interactions (ATM withdrawal, wire transfer, mobile deposit). Linking enables interaction replay for investigations, employee review (insider fraud detection), f',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each alert is classified by a fraud typology. N:1 relationship. No bidirectional conflict (typology does not have fraud_alert_id FK back). Normalizing: fraud_typology (STRING) is replaced by FK to typ',
    `account_number` STRING COMMENT 'The business-facing account number associated with the fraud alert. Masked or tokenized in some environments for PCI/PII compliance.',
    `alert_number` STRING COMMENT 'Business-facing unique alert reference number generated by the fraud detection system for tracking and case management purposes.. Valid values are `^FA-[0-9]{10}$`',
    `alert_status` STRING COMMENT 'Current lifecycle status of the fraud alert indicating the stage of investigation and disposition workflow.. Valid values are `new|under_review|escalated|closed|false_positive|confirmed_fraud`',
    `assigned_analyst_name` STRING COMMENT 'Full name of the fraud analyst assigned to the alert for investigation and case management.',
    `card_number_last_four` STRING COMMENT 'Last four digits of the payment card number involved in the alert, used for identification without exposing full PCI data.. Valid values are `^[0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this fraud alert record was first inserted into the data warehouse or lakehouse.',
    `customer_contact_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was contacted regarding the fraud alert.',
    `customer_contacted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer was contacted during the alert investigation for verification or additional information.',
    `customer_response` STRING COMMENT 'Classification of the customers response when contacted about the alert, indicating whether they confirmed the transaction as legitimate or fraudulent.. Valid values are `confirmed_legitimate|confirmed_fraud|no_response|disputed`',
    `detection_method` STRING COMMENT 'The detection mechanism or source that generated the fraud alert, indicating whether it was triggered by automated rules, ML models, behavioral analytics, or external sources.. Valid values are `rule_based|machine_learning|behavioral_analytics|manual_referral|customer_report|third_party_alert`',
    `disposition_code` STRING COMMENT 'Final outcome classification assigned by the analyst after investigation, indicating whether the alert represents genuine fraud, a false positive, or requires further action.. Valid values are `confirmed_fraud|false_positive|suspicious_no_action|escalated_to_case|customer_verified|pending_information`',
    `disposition_reason` STRING COMMENT 'Free-text explanation or structured reason code documenting the rationale for the disposition decision, supporting audit and quality assurance.',
    `escalated_to_case_id` BIGINT COMMENT 'Identifier of the fraud case created when this alert was escalated for formal investigation, chargeback, or law enforcement referral.',
    `false_positive_reason` STRING COMMENT 'Structured reason or free-text explanation documenting why the alert was classified as a false positive, used for rule tuning and model retraining.',
    `generated_timestamp` TIMESTAMP COMMENT 'The date and time when the fraud alert was generated by the transaction monitoring system. This is the principal business event timestamp for the alert lifecycle.',
    `geolocation_city` STRING COMMENT 'City name derived from IP geolocation or transaction metadata, used for anomaly detection and travel pattern analysis.',
    `ip_address` STRING COMMENT 'IP address from which the transaction or session originated, used for geolocation and device fingerprinting analysis.',
    `loss_amount` DECIMAL(18,2) COMMENT 'Confirmed monetary loss amount resulting from the fraud event, if the alert was dispositioned as confirmed fraud. Used for loss reporting and recovery tracking.',
    `merchant_name` STRING COMMENT 'Name of the merchant or counterparty involved in the transaction that triggered the fraud alert, if applicable.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudulent transaction through chargeback, insurance claim, or other recovery mechanisms.',
    `review_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud analyst completed the investigation and assigned a final disposition to the alert.',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud analyst began reviewing the alert, marking the transition from new to under review status.',
    `sar_filed_flag` BOOLEAN COMMENT 'Boolean indicator of whether a Suspicious Activity Report was filed with FinCEN as a result of this fraud alert.',
    `sar_filing_date` DATE COMMENT 'Date on which the SAR was filed with FinCEN, if applicable.',
    `score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the detection engine indicating the likelihood of fraud, typically ranging from 0 to 100 or 0 to 999 depending on model configuration.',
    `severity` STRING COMMENT 'Risk severity classification assigned to the alert based on potential fraud exposure, transaction amount, and customer risk profile.. Valid values are `low|medium|high|critical`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the transaction that triggered the fraud alert, in the transaction currency.',
    `transaction_channel` STRING COMMENT 'The channel or interface through which the triggering transaction was initiated (e.g., online banking, mobile app, ATM, branch, point-of-sale). [ENUM-REF-CANDIDATE: online|mobile|atm|branch|phone|mail|pos — 7 candidates stripped; promote to reference product]',
    `transaction_date` DATE COMMENT 'The business date on which the triggering transaction occurred.',
    `transaction_type` STRING COMMENT 'Classification of the transaction that triggered the alert (e.g., wire transfer, card purchase, ACH debit, ATM withdrawal).',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp indicating when this fraud alert record was last modified in the data warehouse or lakehouse.',
    CONSTRAINT pk_fraud_alert PRIMARY KEY(`fraud_alert_id`)
) COMMENT 'Transactional record capturing individual fraud detection alerts generated by real-time transaction monitoring rules, machine learning models, or behavioral analytics engines. Each alert references the triggering transaction or event, the detection rule or model that fired, alert severity, alert status (new, reviewed, escalated, closed), and the disposition action taken by the analyst. Feeds the fraud case creation workflow when alerts are confirmed or escalated. Sourced from NICE Actimize transaction monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Primary key for investigation',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Fraud investigations may be conducted jointly with or reviewed by internal audit for independence and control assessment. Banking operations require coordinated fraud/audit investigation for significa',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud investigations collect interaction records as evidence. Linking enables audit trail reconstruction, regulatory exam support (demonstrating transaction monitoring controls), litigation evidence p',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud investigations collect session data as evidence. Linking enables chain-of-custody tracking, legal hold management, courtroom evidence presentation, regulatory exam support, and forensic timeline',
    `case_id` BIGINT COMMENT 'Reference to the parent fraud case that this investigation is associated with. Links to the fraud case management entity.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: An investigation can focus on a specific fraud incident within the broader case. N:1 relationship. No bidirectional conflict (fraud_incident does not have investigation_id FK back). Investigation trac',
    `employee_id` BIGINT COMMENT 'Employee identifier of the fraud investigator currently assigned to this investigation. Links to the Human Capital Management system employee master.',
    `investigation_last_modified_by_employee_id` BIGINT COMMENT 'Employee identifier of the user who last modified the investigation record. Links to the Human Capital Management system employee master.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Fraud investigations examine investor account activity (transaction patterns, velocity analysis, behavioral anomalies). Investigation workflows require direct linkage to investor accounts for evidence',
    `previous_investigation_id` BIGINT COMMENT 'Reference to the preceding investigation phase in a multi-phase investigation workflow. Null for initial investigation phase.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each investigation can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have investigation_id FK back). Normalizing: fraud_typology (STRING) is replaced ',
    `chargeback_initiated_flag` BOOLEAN COMMENT 'Indicates whether a chargeback process was initiated with card networks or payment processors based on investigation findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system. Used for audit trail and data lineage.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified of the investigation outcome. Null if customer notification has not occurred.',
    `customer_notification_flag` BOOLEAN COMMENT 'Indicates whether the customer was formally notified of the investigation outcome and any actions taken (e.g., account restrictions, fraud loss reimbursement).',
    `disposition_rationale` STRING COMMENT 'Detailed explanation of the reasoning behind the recommended disposition. Supports audit trail and regulatory review.',
    `end_date` DATE COMMENT 'Date when the investigation was formally closed or completed. Null for ongoing investigations.',
    `evidence_items_count` STRING COMMENT 'Total number of evidence items collected and catalogued during this investigation (e.g., transaction records, device logs, interview transcripts, surveillance footage).',
    `evidence_summary` STRING COMMENT 'High-level summary of key evidence gathered during the investigation. Used for case review and escalation briefings.',
    `findings_narrative` STRING COMMENT 'Detailed narrative of investigation findings, analysis, and conclusions. Forms the basis for disposition recommendations and SAR (Suspicious Activity Report) narratives.',
    `fraud_loss_amount` DECIMAL(18,2) COMMENT 'Total monetary loss attributed to the fraud as determined by the investigation. Expressed in the banks base currency.',
    `fraud_loss_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fraud loss amount.. Valid values are `^[A-Z]{3}$`',
    `interview_conducted_flag` BOOLEAN COMMENT 'Indicates whether a formal customer or witness interview was conducted as part of this investigation.',
    `interview_date` DATE COMMENT 'Date when the customer or witness interview was conducted. Null if no interview was performed.',
    `interview_notes` STRING COMMENT 'Summary notes from customer or witness interviews conducted during the investigation. May include key statements, admissions, or denials.',
    `investigation_number` STRING COMMENT 'Business-facing unique investigation identifier used for tracking and reporting. Typically system-generated with prefix INV- followed by numeric sequence.. Valid values are `^INV-[0-9]{8,12}$`',
    `investigation_status` STRING COMMENT 'Current operational status of the investigation within its phase. Indicates whether the investigation is actively being worked, pending review, escalated, or completed.. Valid values are `open|in_progress|pending_review|escalated|completed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was last updated. Tracks the most recent change to any field in the record.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the case was referred (e.g., FBI, Secret Service, local police department).',
    `law_enforcement_case_number` STRING COMMENT 'Case or incident number assigned by the law enforcement agency for tracking the criminal investigation.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case has been referred to law enforcement agencies for criminal investigation or prosecution.',
    `methodology` STRING COMMENT 'Primary investigative approach or technique applied during this investigation phase. May include transaction pattern analysis, device fingerprinting, customer interviews, video surveillance review, or third-party data correlation.. Valid values are `transaction_analysis|device_forensics|customer_interview|surveillance_review|third_party_data|multi_method`',
    `multi_phase_investigation_flag` BOOLEAN COMMENT 'Indicates whether this investigation is part of a multi-phase investigation requiring sequential stages with different investigators or specialized skill sets.',
    `notes` STRING COMMENT 'Free-form notes and observations recorded by investigators during the investigation process. Supports case documentation and knowledge transfer.',
    `phase` STRING COMMENT 'Current phase of the investigation workflow. Tracks progression from initial review through deep investigation, potential legal referral, SAR (Suspicious Activity Report) escalation, or closure.. Valid values are `initial_review|deep_investigation|legal_referral|sar_escalation|closed|suspended`',
    `priority` STRING COMMENT 'Priority level assigned to the investigation based on loss amount, customer impact, regulatory risk, or reputational risk. Determines resource allocation and response timelines.. Valid values are `critical|high|medium|low`',
    `recommended_disposition` STRING COMMENT 'Investigators recommended outcome or disposition for the case based on investigation findings. Determines next steps including SAR filing, legal action, or case closure.. Valid values are `confirmed_fraud|no_fraud|inconclusive|referred_to_compliance|referred_to_legal|customer_error`',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudster, third parties, or through chargeback processes as a result of this investigation.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this investigation is subject to regulatory reporting requirements beyond SAR filing (e.g., CTR - Currency Transaction Report, OFAC reporting).',
    `sar_escalation_flag` BOOLEAN COMMENT 'Indicates whether this investigation has been escalated for SAR (Suspicious Activity Report) filing to FinCEN due to suspicious activity meeting regulatory thresholds.',
    `sar_filing_date` DATE COMMENT 'Date when the SAR (Suspicious Activity Report) was filed with FinCEN based on this investigations findings. Null if no SAR was filed.',
    `sar_reference_number` STRING COMMENT 'FinCEN-assigned reference number for the filed SAR (Suspicious Activity Report). Used for tracking and follow-up with regulatory authorities.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the investigation exceeded its SLA (Service Level Agreement) target completion date. Used for performance monitoring and escalation.',
    `sla_target_completion_date` DATE COMMENT 'Target date by which the investigation should be completed per internal SLA (Service Level Agreement) policies. Based on case priority and regulatory requirements.',
    `source_system` STRING COMMENT 'Name of the case management platform or system where this investigation was conducted (e.g., NICE Actimize, Oracle Financial Crime, internal case management system).',
    `start_date` DATE COMMENT 'Date when the investigation was formally initiated. Used for SLA (Service Level Agreement) tracking and regulatory reporting timelines.',
    `team` STRING COMMENT 'Name or code of the specialized fraud investigation team handling this case (e.g., Card Fraud Unit, Wire Fraud Unit, AML Investigation Team).',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Operational entity tracking the investigation workflow associated with a fraud case within the banks case management platform (NICE Actimize, Oracle Financial Crime). Captures investigation phase (initial review, deep investigation, legal referral, SAR escalation), assigned investigator employee ID, investigation start and end dates, methodology applied (transaction analysis, device forensics, customer interview, surveillance review), evidence items gathered, interview records, findings narrative, recommended disposition (confirmed fraud, no fraud, inconclusive, referred to compliance), and escalation flags. Supports multi-phase investigations where a single case may require sequential investigation stages with different investigators or skill sets. Feeds SAR narrative generation and law enforcement referral packages.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`fraud_incident` (
    `fraud_incident_id` BIGINT COMMENT 'Unique identifier for the fraud incident record. Primary key.',
    `account_transaction_id` BIGINT COMMENT 'Reference identifier linking this fraud incident to the specific transaction or account activity that was fraudulent. May reference payment, transfer, withdrawal, or other transaction types.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fraud incidents track the specific channel exploited for operational fraud reviews, Basel II operational risk capital calculations, and channel security assessments. Enables channel-level fraud loss a',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the incident amount (e.g., USD, EUR, GBP).',
    `deposit_account_id` BIGINT COMMENT 'Reference to the customer account affected by this fraud incident.',
    `detection_rule_id` BIGINT COMMENT 'Reference to the fraud detection rule configuration that flagged this incident, if applicable.',
    `device_fingerprint_id` BIGINT COMMENT 'Unique identifier of the device used to conduct the fraudulent transaction (e.g., mobile device ID, browser fingerprint, ATM terminal ID).',
    `employee_id` BIGINT COMMENT 'Reference to the fraud investigator or analyst assigned to investigate this incident.',
    `fraud_alert_id` BIGINT COMMENT 'Reference to the fraud detection alert that triggered the creation of this incident, if system-detected.',
    `case_id` BIGINT COMMENT 'Reference to the parent fraud case under which this incident is investigated. Multiple incidents may be linked to a single fraud case.',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Fraud incidents involve specific fund transactions (forged redemption instructions, unauthorized switches, identity theft). Incident tracking and investigation workflows require direct linkage to the ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Trading fraud incidents (unauthorized trades, front-running, spoofing) require instrument tracking for incident recording, pattern analysis, and regulatory incident reporting in securities trading ope',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Fraud incidents map to specific interactions for loss accounting, GL posting reconciliation, operational loss event reporting (Basel II), and transaction-level fraud analytics. Enables precise fraud l',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Fraud incidents on wealth accounts (unauthorized trades, account takeover, advisor fraud) require portfolio-level tracking for loss calculation, regulatory reporting, and client restitution. Operation',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Incidents classify merchant types for fraud pattern analysis, MCC-based trend reporting, and detection rule effectiveness measurement. Standard card fraud investigation practice. New FK replaces denor',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who is the victim of the fraud incident.',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Fraud incidents capture the session context where fraud occurred. Essential for chargeback defense (proving customer authentication), customer dispute resolution (session timeline evidence), fraud pat',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Incidents track transaction location for cross-border fraud pattern analysis, jurisdiction determination, and country-level risk reporting. Core fraud investigation and reporting requirement. New FK r',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each fraud incident is classified by a fraud typology. N:1 relationship. No bidirectional conflict (typology does not have fraud_incident_id FK back). Normalizing: fraud_typology_code and fraud_typolo',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount involved in the fraudulent transaction or activity. Represents the gross exposure or loss amount before any recovery.',
    `card_number_last_four` STRING COMMENT 'Last four digits of the payment card involved in the fraud incident, used for identification without exposing full card number.. Valid values are `^[0-9]{4}$`',
    `chargeback_date` DATE COMMENT 'Date when the chargeback was filed for this fraud incident, if applicable.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether a chargeback was initiated for this fraud incident (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fraud incident record was first created in the system.',
    `customer_reported_flag` BOOLEAN COMMENT 'Indicates whether the fraud incident was reported by the customer (True) or detected by internal systems (False).',
    `detection_method` STRING COMMENT 'Method by which the fraud incident was detected (e.g., system rule trigger, machine learning model alert, customer-reported, manual review, third-party alert).. Valid values are `system_rule|ml_model|customer_report|manual_review|third_party_alert`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud incident was detected by the system or reported by the customer.',
    `disposition_code` STRING COMMENT 'Final outcome or disposition of the fraud incident investigation (e.g., confirmed fraud, false positive, customer error, merchant error, unresolved, pending).. Valid values are `confirmed_fraud|false_positive|customer_error|merchant_error|unresolved|pending`',
    `incident_description` STRING COMMENT 'Detailed narrative description of the fraudulent event, including circumstances, methods used, and any relevant context for investigation.',
    `incident_status` STRING COMMENT 'Current lifecycle status of the fraud incident within the investigation workflow.. Valid values are `open|under_investigation|confirmed|dismissed|closed|escalated`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the fraudulent event occurred or was first detected. Represents the real-world event time of the fraudulent act.',
    `investigation_close_date` DATE COMMENT 'Date when the investigation of this fraud incident was completed and closed.',
    `investigation_start_date` DATE COMMENT 'Date when the formal investigation of this fraud incident began.',
    `ip_address` STRING COMMENT 'IP address from which the fraudulent online or mobile transaction was initiated.',
    `law_enforcement_case_number` STRING COMMENT 'Case number assigned by law enforcement agency if the fraud incident was reported to police or other authorities.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement authorities were notified about this fraud incident (True) or not (False).',
    `loss_amount` DECIMAL(18,2) COMMENT 'Actual financial loss incurred by the bank or customer after any recoveries, chargebacks, or insurance claims. May differ from incident amount.',
    `merchant_name` STRING COMMENT 'Name of the merchant or payee involved in the fraudulent transaction, if applicable (e.g., for card fraud or unauthorized payments).',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudulent transaction through chargeback, insurance claim, or other recovery mechanisms.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this fraud incident for tracking and reporting purposes.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation findings, resolution actions taken, and final disposition rationale.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to this fraud incident by the fraud detection system, typically ranging from 0 to 100, with higher scores indicating higher fraud risk.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with regulatory authorities for this fraud incident (True) or not (False).',
    `sar_filing_date` DATE COMMENT 'Date when the SAR was filed with FinCEN or other regulatory authority for this fraud incident.',
    `transaction_location` STRING COMMENT 'Geographic location where the fraudulent transaction occurred (city, state, country) or IP address for online transactions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this fraud incident record was last modified or updated.',
    CONSTRAINT pk_fraud_incident PRIMARY KEY(`fraud_incident_id`)
) COMMENT 'Transactional record capturing a confirmed or suspected fraudulent event at the transaction or account level. Represents the specific fraudulent act (unauthorized transaction, counterfeit card use, wire fraud attempt, check fraud, identity theft event) linked to a fraud case. Captures incident date and time, incident channel (ATM, online, branch, wire, ACH), fraud typology code, transaction reference, monetary amount involved, currency, and whether the incident was customer-reported or system-detected. Multiple incidents may be linked to a single fraud case.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Primary key for chargeback',
    `deposit_account_id` BIGINT COMMENT 'Reference to the cardholder account affected by the chargeback.',
    `finding_id` BIGINT COMMENT 'Foreign key linking to audit.finding. Business justification: Chargeback patterns trigger audit findings related to merchant monitoring or card controls. Banking operations analyze chargeback trends to identify control weaknesses, requiring linkage from chargeba',
    `card_transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being disputed through this chargeback.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, GBP).',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Chargebacks document the channel where the disputed transaction occurred. Required for chargeback representment (channel-specific evidence requirements), network dispute resolution, channel-specific f',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or investigator assigned to review and manage the chargeback case.',
    `case_id` BIGINT COMMENT 'Reference to the fraud case that triggered or is associated with this chargeback. Links chargeback to the originating fraud investigation.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: A chargeback can be linked to the underlying fraud incident that triggered it. N:1 relationship. No bidirectional conflict (fraud_incident does not have chargeback_id FK back). Chargeback has its own ',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Chargebacks reference specific fund transactions (disputed card-funded subscriptions). Chargeback processing and representment workflows require direct linkage to the underlying fund transaction for e',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Chargebacks generate accounting entries (debit loss account, credit customer account or suspense) that must be traceable to specific journal entries for subledger reconciliation, SOX controls, and aud',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Chargebacks occur on investor account transactions when fund purchases are disputed (card-funded subscriptions, unauthorized debits). Chargeback processing requires linking to investor accounts for re',
    `merchant_id` BIGINT COMMENT 'Unique identifier for the merchant where the original transaction occurred. Used for merchant risk assessment and chargeback ratio monitoring.',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Chargebacks analyze merchant industry for dispute trend analysis, high-risk MCC identification, and chargeback prevention strategy. Card network and fraud operations requirement. New FK replaces denor',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Chargebacks represent operational losses (Basel event type ET6 - External Fraud) that must be captured in operational risk loss databases. Required for SMA capital calculation, CCAR/DFAST stress testi',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Chargebacks reference the original transaction interaction for representment evidence (signed receipts, authorization codes, delivery confirmation, EMV chip data). Critical for chargeback defense, net',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who initiated the chargeback dispute.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each chargeback can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have chargeback_id FK back). Normalizing: fraud_typology (STRING) is replaced by FK ',
    `acquirer_bin` STRING COMMENT 'Bank Identification Number of the acquiring bank that processed the original transaction. Identifies the financial institution responsible for the merchant relationship.. Valid values are `^[0-9]{6,8}$`',
    `arbitration_filed_date` DATE COMMENT 'The date when either party escalated the dispute to formal arbitration with the card network.',
    `card_network` STRING COMMENT 'The payment card network that governs the chargeback dispute process (e.g., Visa, Mastercard, American Express). Each network has distinct rules and timelines.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_type` STRING COMMENT 'Type of payment card involved in the disputed transaction (credit, debit, prepaid, or charge card).. Valid values are `credit|debit|prepaid|charge`',
    `chargeback_status` STRING COMMENT 'Current processing status of the chargeback within the current stage. Indicates whether the chargeback is awaiting action, under investigation, or has reached a decision point.. Valid values are `pending|under_review|accepted|rejected|reversed|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this chargeback record was first created in the system.',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The monetary amount being disputed in the chargeback, typically matching the original transaction amount or a portion thereof.',
    `fee` DECIMAL(18,2) COMMENT 'Administrative fee charged by the card network or acquiring bank for processing the chargeback. Typically ranges from $15 to $100 depending on the network and merchant agreement.',
    `fraud_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the chargeback is related to confirmed or suspected fraudulent activity. True if the chargeback reason code indicates fraud.',
    `initiated_date` DATE COMMENT 'The date when the chargeback was first initiated by the cardholder or issuing bank.',
    `investigation_notes` STRING COMMENT 'Free-text field capturing investigator notes, findings, and supporting documentation references related to the chargeback investigation and resolution process.',
    `issuer_bin` STRING COMMENT 'Bank Identification Number of the card-issuing bank. Identifies the financial institution that issued the payment card to the cardholder.. Valid values are `^[0-9]{6,8}$`',
    `loss_amount` DECIMAL(18,2) COMMENT 'The net financial loss incurred by the bank after resolution of the chargeback, accounting for any recoveries, fees, and adjustments.',
    `masked_card_number` STRING COMMENT 'Partially masked payment card number (e.g., ****1234) used to identify the card while maintaining PCI DSS compliance. Only the last four digits are visible.',
    `merchant_name` STRING COMMENT 'Name of the merchant or business where the disputed transaction took place.',
    `network_case_number` STRING COMMENT 'Unique case identifier assigned by the payment card network (Visa, Mastercard, Amex) for tracking the chargeback through the network dispute resolution process.',
    `original_transaction_amount` DECIMAL(18,2) COMMENT 'The full amount of the original transaction that is subject to the chargeback dispute.',
    `original_transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the original transaction amount.. Valid values are `^[A-Z]{3}$`',
    `original_transaction_date` DATE COMMENT 'The date when the original disputed transaction was processed.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the chargeback as defined by the card network (e.g., Visa reason codes 10.4 for fraud, 13.1 for merchandise not received). Each network maintains its own reason code taxonomy.',
    `reason_description` STRING COMMENT 'Human-readable description of the chargeback reason, providing context for the dispute (e.g., Fraudulent Transaction - Card Not Present, Services Not Provided, Duplicate Processing).',
    `received_timestamp` TIMESTAMP COMMENT 'The precise date and time when the bank received the chargeback notification from the payment network.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The amount recovered by the bank through the chargeback process, representment, or other loss recovery mechanisms. May differ from the original dispute amount.',
    `representment_filed_date` DATE COMMENT 'The date when the merchant or acquiring bank filed a representment (rebuttal) to challenge the chargeback.',
    `resolution_date` DATE COMMENT 'The date when the chargeback dispute reached final resolution, either through acceptance, reversal, or arbitration decision.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the chargeback dispute. Cardholder favor means the chargeback stands; merchant favor means the chargeback was reversed; partial reversal indicates a compromise; withdrawn means the cardholder retracted the dispute; expired means no response was filed within the deadline.. Valid values are `cardholder_favor|merchant_favor|partial_reversal|withdrawn|expired`',
    `response_deadline_date` DATE COMMENT 'The date by which the bank or merchant must respond to the chargeback to avoid automatic acceptance. Deadlines are typically set by card network rules (e.g., 30-45 days).',
    `sar_filed_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a Suspicious Activity Report was filed with FinCEN in connection with this chargeback due to suspected fraud or money laundering.',
    `stage` STRING COMMENT 'Current stage in the chargeback dispute lifecycle. First chargeback is the initial dispute; representment is the merchants response; pre-arbitration and arbitration are escalation stages; closed indicates final resolution.. Valid values are `first_chargeback|representment|pre_arbitration|arbitration|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this chargeback record was last modified, reflecting the most recent status change or data update.',
    CONSTRAINT pk_chargeback PRIMARY KEY(`chargeback_id`)
) COMMENT 'Master entity managing the full lifecycle of payment card chargebacks initiated in response to disputed or fraudulent transactions. Captures chargeback reason code (per Visa/Mastercard/Amex network rules), dispute amount, original transaction reference, chargeback stage (first chargeback, representment, pre-arbitration, arbitration), network case number, merchant ID, acquirer BIN, response deadlines, and final resolution outcome. Includes the complete audit trail of lifecycle events: network messages, representment filings, arbitration submissions, and resolution events with timestamps and responsible parties. Supports merchant fraud risk assessment including chargeback ratios and network monitoring program enrollment. Linked to fraud cases where chargebacks arise from confirmed fraud.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`sar_filing` (
    `sar_filing_id` BIGINT COMMENT 'Primary key for sar_filing',
    `alco_meeting_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_meeting. Business justification: ALCO reviews significant SAR filings for reputational risk, regulatory examination readiness, and potential liquidity impacts from large fraud losses. Banks escalate material fraud cases to ALCO for g',
    `amended_sar_sar_filing_id` BIGINT COMMENT 'Reference to the original SAR filing that this record amends, if amendment_flag is true.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts reported in the SAR.',
    `case_id` BIGINT COMMENT 'Reference to the originating fraud investigation case that triggered this SAR filing.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: SARs are filed on suspicious investor account activity (structuring via fund purchases, layering through switches, integration patterns). Regulatory reporting requires direct linkage to investor accou',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or compliance officer who prepared the SAR filing.',
    `regulatory_finding_id` BIGINT COMMENT 'Foreign key linking to audit.regulatory_finding. Business justification: SAR filings are frequently referenced in regulatory findings when examiners review AML/BSA compliance. Banking operations require linkage from SAR to regulatory finding for exam response, remediation ',
    `party_id` BIGINT COMMENT 'Reference to the primary party (customer or entity) who is the subject of the suspicious activity report.',
    `tertiary_sar_approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the authorized officer who gave final approval for the SAR filing submission to FinCEN.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each SAR filing can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have sar_filing_id FK back). Normalizing: fraud_typology (STRING) is replaced by FK ',
    `account_number` STRING COMMENT 'Primary account number involved in the suspicious activity. May be masked or tokenized depending on internal security policy.',
    `activity_description` STRING COMMENT 'Detailed narrative description of the suspicious activity, including facts, patterns, and rationale for filing the SAR. This is the core investigative summary.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this SAR filing is an amendment to a previously filed SAR.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: SARs filed by fraud teams reference the originating AML case for regulatory coordination. Banks track which AML case triggered the SAR for audit trail, regulatory exams, and FinCEN reporting consisten',
    `approval_date` DATE COMMENT 'Date when the SAR filing received final internal approval before submission to FinCEN.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAR filing record was first created in the fraud case management system.',
    `filing_date` DATE COMMENT 'Date when the SAR was officially filed with FinCEN. This is the principal business event timestamp for the SAR filing.',
    `filing_deadline_date` DATE COMMENT 'Regulatory deadline by which the SAR must be filed with FinCEN, typically 30 days from initial detection of suspicious activity.',
    `filing_institution_contact_name` STRING COMMENT 'Name of the individual at the filing institution who can be contacted regarding this SAR.',
    `filing_institution_contact_phone` STRING COMMENT 'Phone number of the filing institution contact person for follow-up inquiries.',
    `filing_institution_name` STRING COMMENT 'Legal name of the financial institution filing the SAR with FinCEN.',
    `filing_institution_tin` STRING COMMENT 'Employer Identification Number (EIN) of the filing financial institution.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the SAR filing within the institutions workflow and FinCEN submission process. [ENUM-REF-CANDIDATE: draft|pending_review|approved|filed|amended|withdrawn|rejected — 7 candidates stripped; promote to reference product]',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the SAR was submitted to FinCENs BSA E-Filing system.',
    `fincen_acknowledgment_date` DATE COMMENT 'Date when FinCEN acknowledged receipt and acceptance of the SAR filing.',
    `fincen_bsa_reference` STRING COMMENT 'Unique identifier assigned by FinCEN upon successful submission and acknowledgment of the SAR filing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SAR filing record was last updated in the fraud case management system.',
    `law_enforcement_agency_name` STRING COMMENT 'Name of the law enforcement agency contacted or involved in the investigation of this suspicious activity.',
    `law_enforcement_contact_date` DATE COMMENT 'Date when law enforcement was contacted regarding this suspicious activity, if applicable.',
    `prior_sar_reference` STRING COMMENT 'Reference to any prior SAR filings related to the same subject or activity, enabling continuity tracking.',
    `rejection_reason` STRING COMMENT 'Reason provided by FinCEN or internal compliance for rejecting the SAR filing, if applicable.',
    `sar_number` STRING COMMENT 'Business identifier for the SAR filing, typically assigned by the financial institutions SAR management system.',
    `sar_type` STRING COMMENT 'Classification of the SAR based on the primary suspicious activity driver. This entity focuses on fraud-originated SARs distinct from compliance AML SARs.. Valid values are `fraud_related|aml_related|combined`',
    `subject_address` STRING COMMENT 'Full address of the subject party as known to the financial institution at the time of filing.',
    `subject_email` STRING COMMENT 'Email address of the subject party if available and relevant to the suspicious activity.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `subject_name` STRING COMMENT 'Full legal name of the individual or entity who is the subject of the SAR filing.',
    `subject_phone` STRING COMMENT 'Primary contact phone number for the subject party.',
    `subject_tin` STRING COMMENT 'Tax identification number (SSN, EIN, or ITIN) of the subject party, as required by FinCEN SAR reporting.',
    `suspicious_activity_end_date` DATE COMMENT 'Date when the suspicious activity being reported ended or was last observed. Nullable for ongoing activity.',
    `suspicious_activity_start_date` DATE COMMENT 'Date when the suspicious activity being reported first began or was first detected.',
    `suspicious_activity_type_code` STRING COMMENT 'FinCEN-defined code(s) categorizing the type of suspicious activity. Multiple codes may be concatenated or stored as delimited list. [ENUM-REF-CANDIDATE: fraud_card|fraud_ach|fraud_wire|fraud_check|fraud_identity_theft|fraud_account_takeover|fraud_elder_financial_exploitation|fraud_mortgage|fraud_consumer_loan|fraud_commercial_loan|fraud_securities|fraud_insurance|fraud_other — promote to reference product]',
    `total_suspicious_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of all transactions or activity deemed suspicious and reported in this SAR.',
    `transaction_count` STRING COMMENT 'Number of individual transactions or events that comprise the suspicious activity being reported.',
    `withdrawal_reason` STRING COMMENT 'Explanation for why a SAR filing was withdrawn, if applicable. Populated only when filing_status is withdrawn.',
    CONSTRAINT pk_sar_filing PRIMARY KEY(`sar_filing_id`)
) COMMENT 'Master entity representing a Suspicious Activity Report (SAR) filed with FinCEN under BSA obligations arising from fraud investigations. Captures SAR type (fraud-related vs AML-related — this entity covers fraud-originated SARs distinct from compliance AML SARs), filing date, subject information, activity description, suspicious activity type codes, monetary amounts, filing status (draft, filed, amended, withdrawn), FinCEN acknowledgment reference, and the originating fraud case reference. Managed within NICE Actimize SAR filing module.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`loss_recovery` (
    `loss_recovery_id` BIGINT COMMENT 'Unique identifier for the loss recovery record. Primary key for the loss recovery entity.',
    `account_transaction_id` BIGINT COMMENT 'Reference to the specific transaction that resulted in the fraud loss, if applicable. Links to transaction history systems.',
    `finding_id` BIGINT COMMENT 'Foreign key linking to audit.finding. Business justification: Loss recovery efforts are subject to audit findings on recovery process effectiveness. Banking operations require audit review of recovery controls and procedures, necessitating linkage from loss reco',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the loss amount. Required for multi-currency operations and regulatory reporting.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the specific account (deposit, card, loan) where the fraud loss occurred, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the fraud investigator or recovery specialist assigned to manage this loss recovery case.',
    `case_id` BIGINT COMMENT 'Reference to the confirmed fraud case that generated this loss. Links to the fraud case management system.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Loss recovery can be linked to the specific fraud incident for which recovery is being pursued. N:1 relationship. No bidirectional conflict (fraud_incident does not have loss_recovery_id FK back). Rec',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fraud loss recoveries (insurance claims, chargebacks, legal restitution) must be posted to GL accounts to offset original loss entries, update net loss positions for regulatory reporting, and maintain',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Loss recovery tracking for fraud events in wealth accounts requires portfolio-level attribution for insurance claims, client reimbursement, and regulatory reporting (CCAR, Basel). Operational requirem',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Recovery amounts offset gross operational risk losses in Basel capital calculations. Operational risk events must track both gross loss and recoveries (insurance, chargebacks, legal) to calculate net ',
    `party_id` BIGINT COMMENT 'Reference to the customer whose account or relationship was impacted by the fraud loss, if applicable.',
    `basel_event_type_code` STRING COMMENT 'Basel III operational risk event type classification code. Fraud losses typically fall under Level 1 Event Type 1 (Internal Fraud) or 3 (Clients, Products & Business Practices).. Valid values are `^[1-7].[1-9]$`',
    `business_line` STRING COMMENT 'The line of business (LOB) where the fraud loss occurred. Aligns with Basel III business line segmentation for operational risk capital allocation.. Valid values are `retail_banking|corporate_banking|payment_services|trading_sales|asset_management|commercial_banking`',
    `ccar_loss_event_flag` BOOLEAN COMMENT 'Indicates whether this loss event is included in the historical loss data set used for CCAR stress testing scenarios.',
    `chargeback_reference_number` STRING COMMENT 'Reference number for merchant or network chargeback initiated for card fraud losses. Links to payment network dispute systems.. Valid values are `^[A-Z0-9]{10,25}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'The timestamp when the loss recovery case was closed and final disposition was recorded. Null if the case is still open.',
    `cost_center_code` STRING COMMENT 'The cost center responsible for the business unit where the loss occurred. Used for internal management reporting and loss attribution.. Valid values are `^[A-Z0-9]{4,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this loss recovery record was first created in the system.',
    `gross_loss_amount` DECIMAL(18,2) COMMENT 'The total financial loss amount before any recoveries, expressed in the reporting currency. Represents the initial impact of the fraud event.',
    `insurance_claim_number` STRING COMMENT 'Reference number for the insurance claim filed for this loss, if applicable. Links to external insurance carrier systems.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `insurance_recovery_amount` DECIMAL(18,2) COMMENT 'The portion of the total recovery amount that was received from insurance. Subset of the total recovery amount.',
    `legal_case_number` STRING COMMENT 'Reference number for legal proceedings initiated to recover the loss, if applicable. Links to legal case management systems.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `loss_category` STRING COMMENT 'Classification of the fraud loss by fraud typology. Aligns with internal fraud taxonomy for retail, card, wire, and deposit fraud.. Valid values are `card_fraud|wire_fraud|ach_fraud|check_fraud|account_takeover|identity_theft`',
    `loss_date` DATE COMMENT 'The date when the fraud loss was recognized and recorded in the financial system.',
    `loss_description` STRING COMMENT 'Detailed narrative description of the fraud loss event, including circumstances, methods used, and impact. Confidential business information.',
    `loss_discovery_date` DATE COMMENT 'The date when the fraud loss was first discovered or detected by the institution.',
    `loss_event_number` STRING COMMENT 'Business-readable unique identifier for the loss event, typically formatted as business-line prefix, year, and sequence number.. Valid values are `^[A-Z]{3}-[0-9]{4}-[0-9]{6}$`',
    `loss_status` STRING COMMENT 'Current lifecycle status of the loss recovery record. Tracks the overall case from initial recognition through final disposition.. Valid values are `open|under_review|recovery_in_progress|closed_recovered|closed_written_off`',
    `net_loss_amount` DECIMAL(18,2) COMMENT 'The net financial loss after all recoveries, calculated as gross loss amount minus recovery amount. This is the final loss impact used for regulatory capital calculations.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The total amount recovered from all recovery activities, expressed in the same currency as the gross loss. Null if no recovery has occurred.',
    `recovery_date` DATE COMMENT 'The date when the recovery amount was received or recognized. Null if no recovery has occurred.',
    `recovery_method` STRING COMMENT 'The method or channel through which loss recovery was pursued or achieved. Includes insurance claims, chargeback processes, legal action, and write-offs. [ENUM-REF-CANDIDATE: insurance|merchant_chargeback|network_recovery|legal_judgment|customer_restitution|write_off|other — 7 candidates stripped; promote to reference product]',
    `recovery_notes` STRING COMMENT 'Free-text notes documenting recovery activities, communications with recovery parties, and status updates. Confidential business information.',
    `recovery_status` STRING COMMENT 'Current status of recovery efforts for this loss event. Tracks the lifecycle from initial pursuit through final disposition.. Valid values are `pending|in_progress|partial_recovery|full_recovery|abandoned|write_off`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this loss event must be included in regulatory operational risk loss data reporting under Basel III SMA or CCAR/DFAST stress testing.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN for this fraud loss event, as required under the Bank Secrecy Act.',
    `sar_filing_date` DATE COMMENT 'The date when the SAR was filed with FinCEN, if applicable. Null if no SAR was filed.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this loss recovery record was last modified. Supports audit trail and data lineage tracking.',
    `write_off_approval_authority` STRING COMMENT 'The name or role of the authority who approved the write-off decision, per internal delegation of authority policies.',
    `write_off_date` DATE COMMENT 'The date when the unrecovered loss amount was written off in the general ledger. Null if the loss has not been written off.',
    CONSTRAINT pk_loss_recovery PRIMARY KEY(`loss_recovery_id`)
) COMMENT 'Transactional entity tracking the complete fraud loss lifecycle from initial loss recognition through recovery activities for confirmed fraud cases. Captures loss event details (loss date, loss category, Basel event type code, gross loss amount, business line, GL account reference) and recovery activities (recovery method — insurance, merchant, network, legal judgment, write-off; recovery amount, recovery date, recovery status). Calculates net loss after recovery. Supports financial reconciliation against the general ledger, regulatory loss reporting under Basel III SMA framework, CCAR/DFAST stress testing loss history, operational risk loss data collection, and internal management reporting on fraud financial impact.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`detection_rule` (
    `detection_rule_id` BIGINT COMMENT 'Unique identifier for the fraud detection rule within the transaction monitoring engine.',
    `continuous_monitoring_id` BIGINT COMMENT 'Foreign key linking to audit.continuous_monitoring. Business justification: Fraud detection rules and continuous monitoring programs share similar control monitoring logic. Banking operations coordinate rule development between fraud and audit to ensure consistent control tes',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code applicable when threshold is monetary (e.g., USD, EUR, GBP). Null for non-monetary thresholds.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each detection rule targets a specific fraud typology. N:1 relationship. No bidirectional conflict (typology does not have detection_rule_id FK back). Normalizing: fraud_typology (STRING) is replaced ',
    `alert_priority_score` STRING COMMENT 'Numeric priority score (1-100) assigned to alerts generated by this rule, used for case queue prioritization and resource allocation. Higher scores indicate higher priority.',
    `alert_volume` BIGINT COMMENT 'Total number of alerts generated by this rule during the measurement period. Used for capacity planning and rule efficiency assessment.',
    `approval_authority` STRING COMMENT 'Name or role of the authority who approved the rule for production deployment. Required for audit trail and governance compliance.',
    `approval_date` DATE COMMENT 'Date when the rule was formally approved for production use by the designated approval authority. Part of the rule governance audit trail.',
    `case_conversion_rate` DECIMAL(18,2) COMMENT 'Proportion of alerts that resulted in formal fraud investigation cases, calculated as cases opened divided by total alerts. Indicates rule precision and investigative value.',
    `channel_applicability` STRING COMMENT 'Comma-separated list of banking channels to which this rule applies: online banking, mobile app, ATM (Automated Teller Machine), branch, call center, wire transfer, ACH (Automated Clearing House), card payment. Empty indicates all channels.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the detection rule record was first created in the system. Part of the audit trail for rule lifecycle management.',
    `customer_segment_applicability` STRING COMMENT 'Target customer segments for rule application: retail, commercial, wealth management, institutional. Allows segment-specific tuning of detection thresholds.',
    `detection_effectiveness_score` DECIMAL(18,2) COMMENT 'Composite metric (0-100) evaluating overall rule performance, incorporating true positive rate, false positive rate, and case conversion rate. Used for rule ranking and optimization prioritization.',
    `effective_date` DATE COMMENT 'Date when the detection rule became active in the production monitoring environment. Used for historical analysis and rule lifecycle tracking.',
    `expiration_date` DATE COMMENT 'Date when the detection rule is scheduled to be retired or reviewed. Null for rules without planned expiration. Supports rule governance and periodic review processes.',
    `false_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of legitimate transactions incorrectly flagged as fraud, calculated as false positives divided by total legitimate transactions. Critical for operational efficiency and customer experience.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the detection rule record was last updated. Tracks configuration changes and parameter adjustments over time.',
    `last_tuning_date` DATE COMMENT 'Date when the rule parameters were last adjusted or optimized based on performance analysis. Critical for tracking rule maintenance and effectiveness improvement efforts.',
    `measurement_period_end_date` DATE COMMENT 'End date of the performance measurement period for the recorded metrics. Defines the temporal scope of performance statistics.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the performance measurement period for the recorded metrics. Enables time-series analysis of rule effectiveness.',
    `ml_model_name` STRING COMMENT 'Name or identifier of the machine learning model used for detection, if applicable. References trained model artifacts in the fraud analytics platform.',
    `ml_model_version` STRING COMMENT 'Version identifier of the machine learning model, enabling model lineage tracking and performance comparison across model iterations.',
    `model_type` STRING COMMENT 'Detection methodology employed: rule-based (deterministic logic), machine learning (ML/AI model), hybrid (combination of rules and ML), statistical (statistical anomaly detection).. Valid values are `rule_based|machine_learning|hybrid|statistical`',
    `product_applicability` STRING COMMENT 'Comma-separated list of banking products to which this rule applies: DDA (Demand Deposit Account), savings account, credit card, debit card, wire transfer, loan, investment account. Empty indicates all products.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether confirmed fraud cases from this rule must be included in regulatory reports such as CTR (Currency Transaction Report) or SAR (Suspicious Activity Report) filings.',
    `rule_category` STRING COMMENT 'Classification of the detection rule by fraud detection methodology: velocity check (transaction frequency), amount threshold (monetary limits), geographic anomaly (location-based), device fingerprint (device identification), behavioral pattern (customer behavior analysis), or account takeover (credential compromise detection).. Valid values are `velocity_check|amount_threshold|geographic_anomaly|device_fingerprint|behavioral_pattern|account_takeover`',
    `rule_code` STRING COMMENT 'Unique alphanumeric code assigned to the detection rule for system integration and cross-reference with monitoring platforms such as NICE Actimize or Oracle Financial Crime.',
    `rule_description` STRING COMMENT 'Comprehensive business description of the rules purpose, detection methodology, and intended use cases. Provides context for analysts and auditors.',
    `rule_documentation_url` STRING COMMENT 'URL or file path to detailed technical documentation, configuration guides, and tuning history for the rule. Supports knowledge management and operational continuity.',
    `rule_logic` STRING COMMENT 'Detailed description of the rules detection logic, including conditions, thresholds, and decision criteria. May reference SQL-like expressions, business rules, or machine learning model invocation logic.',
    `rule_name` STRING COMMENT 'Business-friendly name of the fraud detection rule used for identification and reporting purposes.',
    `rule_owner` STRING COMMENT 'Name or identifier of the business unit, team, or individual responsible for rule governance, performance monitoring, and tuning decisions.',
    `rule_severity` STRING COMMENT 'Severity classification of alerts generated by this rule, indicating priority for investigation: critical (immediate action required), high (urgent review), medium (standard review), low (informational).. Valid values are `critical|high|medium|low`',
    `rule_status` STRING COMMENT 'Current operational status of the detection rule: active (in production), inactive (disabled), testing (pilot mode), retired (permanently decommissioned), suspended (temporarily disabled pending review).. Valid values are `active|inactive|testing|retired|suspended`',
    `sar_escalation_flag` BOOLEAN COMMENT 'Indicates whether alerts from this rule automatically trigger SAR (Suspicious Activity Report) escalation workflow for regulatory reporting to FinCEN (Financial Crimes Enforcement Network).',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value: currency (monetary amount), count (transaction frequency), percentage (ratio), score (risk score), or standard deviation (statistical measure).. Valid values are `currency|count|percentage|score|standard_deviation`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold parameter that triggers the rule when exceeded. For amount-based rules, represents monetary limit; for velocity rules, represents transaction count; for behavioral rules, represents deviation score.',
    `time_window_unit` STRING COMMENT 'Unit of time for the evaluation window: minute, hour, day, week, or month. Defines the temporal scope for transaction aggregation and pattern detection.. Valid values are `minute|hour|day|week|month`',
    `time_window_value` STRING COMMENT 'Numeric value defining the lookback or evaluation period for the rule (e.g., 24 for 24 hours, 7 for 7 days). Used in velocity checks and pattern analysis.',
    `true_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of actual fraud cases correctly identified by the rule, calculated as true positives divided by total actual fraud cases. Key performance metric for detection effectiveness.',
    `tuning_frequency_days` STRING COMMENT 'Recommended number of days between rule performance reviews and parameter adjustments. Supports proactive rule maintenance scheduling.',
    CONSTRAINT pk_detection_rule PRIMARY KEY(`detection_rule_id`)
) COMMENT 'Master entity defining fraud detection rules, thresholds, and ML model configurations within the transaction monitoring engine. Captures rule name, category (velocity check, amount threshold, geographic anomaly, device fingerprint, behavioral pattern), rule logic, threshold parameters, channel and product applicability, rule status (active, inactive, testing), effective date, and last tuning date. Includes periodic performance measurement records: true positive rate, false positive rate, alert volume, case conversion rate, detection effectiveness metrics, and measurement period. Supports the complete operational rule tuning lifecycle from initial configuration through performance measurement, governance review, and retirement decisions.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`evidence` (
    `evidence_id` BIGINT COMMENT 'Unique identifier for the fraud evidence item. Primary key for the fraud evidence entity.',
    `workpaper_id` BIGINT COMMENT 'Foreign key linking to audit.workpaper. Business justification: Fraud evidence is referenced in audit workpapers when auditing fraud controls. Banking operations require auditors to review fraud investigation artifacts as evidence of control operation, necessitati',
    `employee_id` BIGINT COMMENT 'Reference to the fraud analyst or investigator who collected or secured this evidence item.',
    `evidence_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user or analyst who last updated this fraud evidence record.',
    `case_id` BIGINT COMMENT 'Reference to the parent fraud case or investigation to which this evidence item is attached.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: Evidence can be collected for a specific fraud incident in addition to the overall case. N:1 relationship. No bidirectional conflict (fraud_incident does not have evidence_id FK back). Evidence can re',
    `fund_transaction_id` BIGINT COMMENT 'Foreign key linking to asset.fund_transaction. Business justification: Evidence collection includes specific fund transaction records (confirmations, instructions, audit trails, timestamps). Chain of custody and legal admissibility requirements necessitate direct linkage',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Evidence can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have evidence_id FK back). Normalizing: fraud_typology (STRING) is replaced by FK to typolo',
    `admissibility_classification` STRING COMMENT 'Legal admissibility classification of the evidence item for use in legal proceedings, regulatory examinations, or law enforcement referrals. Indicates whether the evidence meets evidentiary standards and chain of custody requirements.. Valid values are `admissible|inadmissible|pending_review|conditional`',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was moved to long-term archival storage.',
    `chain_of_custody_status` STRING COMMENT 'Current lifecycle status of the evidence item within the chain of custody process. Tracks whether the evidence has been collected, secured in storage, transferred to another party, archived for long-term retention, or destroyed per retention policy.. Valid values are `collected|secured|transferred|archived|destroyed`',
    `collection_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was collected or extracted from the source system. Represents the principal business event timestamp for evidence capture.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the evidence item based on its sensitivity and the presence of personally identifiable information (PII), protected health information (PHI), or other sensitive data.. Valid values are `public|internal|confidential|restricted`',
    `contains_pii_flag` BOOLEAN COMMENT 'Indicates whether the evidence item contains personally identifiable information (PII) subject to privacy regulations such as GDPR, CCPA, or GLBA.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fraud evidence record was first created in the fraud case management system.',
    `destroyed_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was destroyed per retention policy and legal requirements.',
    `destruction_authorized_by` BIGINT COMMENT 'Reference to the employee or manager who authorized the destruction of the evidence item after confirming retention period expiration and absence of legal holds.',
    `destruction_method` STRING COMMENT 'The method used to destroy the evidence item. Includes secure deletion (for digital files), shredding (for paper documents), degaussing (for magnetic media), or incineration.. Valid values are `secure_deletion|shredding|degaussing|incineration`',
    `evidence_description` STRING COMMENT 'Detailed textual description of the evidence item, including its content, relevance to the fraud case, and any notable characteristics or findings.',
    `evidence_type` STRING COMMENT 'Classification of the evidence item by its nature and format. Includes transaction log extract, device fingerprint record, IP geolocation data, call recording, surveillance footage, document image, network traffic log, customer correspondence, witness statement, and third-party verification response.. Valid values are `transaction_log|device_fingerprint|ip_geolocation|call_recording|surveillance_footage|document_image`',
    `file_format` STRING COMMENT 'The file format or media type of the evidence artifact. Common formats include PDF, image files (JPG, PNG), audio recordings (MP3), video files (MP4), structured data (CSV, XML, JSON), and document formats (DOC, DOCX, TXT). [ENUM-REF-CANDIDATE: pdf|jpg|png|mp3|mp4|csv|xml|json|txt|doc|docx — 11 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'The original or assigned file name of the evidence artifact, including file extension if applicable.',
    `file_size_bytes` BIGINT COMMENT 'The size of the evidence file or artifact in bytes. Used for storage capacity planning and transfer validation.',
    `hash_algorithm` STRING COMMENT 'The cryptographic hash algorithm used to generate the hash value for evidence integrity verification.. Valid values are `SHA-256|SHA-512|MD5`',
    `hash_value` DECIMAL(18,2) COMMENT 'Cryptographic hash (e.g., SHA-256) of the evidence file to ensure integrity and detect tampering. Used to verify that the evidence has not been altered since collection.',
    `internal_audit_reference` STRING COMMENT 'Reference identifier for the internal audit review or control testing for which this evidence item was produced or is relevant.',
    `law_enforcement_agency` STRING COMMENT 'The name or identifier of the law enforcement agency with which the evidence was shared, if applicable.',
    `law_enforcement_case_number` STRING COMMENT 'The case number or reference assigned by the law enforcement agency for tracking the evidence in their investigation.',
    `law_enforcement_shared_flag` BOOLEAN COMMENT 'Indicates whether this evidence item has been shared with law enforcement agencies as part of a criminal investigation or Suspicious Activity Report (SAR) filing.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the evidence item is subject to a legal hold order, preventing its destruction or alteration pending litigation, regulatory examination, or law enforcement investigation.',
    `legal_hold_reference` STRING COMMENT 'Reference identifier for the legal hold order or case that requires preservation of this evidence item.',
    `notes` STRING COMMENT 'Free-text notes or comments from investigators regarding the evidence item, its context, or its significance to the case.',
    `regulatory_exam_reference` STRING COMMENT 'Reference identifier for the regulatory examination or audit request for which this evidence item was produced or is relevant.',
    `relevance_score` DECIMAL(18,2) COMMENT 'A numerical score (0.00 to 100.00) indicating the relevance or importance of this evidence item to the fraud case investigation. Higher scores indicate more critical evidence.',
    `retention_expiration_date` DATE COMMENT 'The date on which the evidence retention period expires and the evidence item becomes eligible for destruction, unless subject to legal hold or extended retention requirements.',
    `retention_period_days` STRING COMMENT 'The number of days the evidence item must be retained per the banks evidence retention policy, regulatory requirements, and legal hold obligations. Drives evidence archival and destruction schedules.',
    `sar_reference_number` STRING COMMENT 'Reference to the Suspicious Activity Report (SAR) filing with FinCEN to which this evidence item is attached or supports.',
    `secure_storage_reference` STRING COMMENT 'Reference identifier or URI pointing to the secure storage location where the evidence file or artifact is stored. May reference document management system, secure file share, or evidence vault.',
    `source_system` STRING COMMENT 'The operational system from which the evidence was collected. Includes core banking system, card processor, digital banking platform, telephony system, physical security system, payment processing hub, and other source systems.. Valid values are `core_banking|card_processor|digital_banking|telephony|physical_security|payment_hub`',
    `transfer_method` STRING COMMENT 'The method used to transfer the evidence item to another party. Includes secure email, encrypted file transfer, physical media (USB, CD), secure portal, or in-person handoff.. Valid values are `secure_email|encrypted_file_transfer|physical_media|secure_portal|in_person`',
    `transfer_recipient` STRING COMMENT 'The name or identifier of the party to whom the evidence item was transferred.',
    `transfer_timestamp` TIMESTAMP COMMENT 'The date and time when the evidence item was transferred to another party, such as law enforcement, legal counsel, or regulatory authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fraud evidence record was last modified in the fraud case management system.',
    CONSTRAINT pk_evidence PRIMARY KEY(`evidence_id`)
) COMMENT 'Operational entity capturing evidence items collected and attached to fraud investigations and cases within the banks fraud case management system. Tracks evidence type (transaction log extract, device fingerprint record, IP geolocation data, call recording, surveillance footage, document image, network traffic log, customer correspondence, witness statement, third-party verification response), evidence source system (core banking, card processor, digital banking platform, telephony, physical security), collection date and time, collecting analyst, chain of custody status (collected, secured, transferred, archived, destroyed), secure storage reference, admissibility classification, and retention period per the banks evidence retention policy. Supports legal referrals, law enforcement evidence packages, regulatory examination responses, and internal audit reviews.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the fraud claim record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Customer fraud claims are received via specific channels (branch, contact center, digital). Tracking this enables claim processing workflow routing, SLA management, Reg E compliance (provisional credi',
    `channel_relationship_manager_id` BIGINT COMMENT 'Foreign key linking to channel.relationship_manager. Business justification: Fraud claims from RM-managed clients are routed to the RM for personalized handling, ensuring high-touch service during fraud resolution, minimizing client attrition, and coordinating provisional cred',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the account associated with the fraud claim.',
    `claim_provisional_credit_account_deposit_account_id` BIGINT COMMENT 'Identifier of the account to which provisional credit was posted.',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Customer fraud claims reference specific interactions. Linking enables claim validation (did transaction occur as claimed?), provisional credit calculation (Reg E 10-day rule), dispute resolution, and',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the claimed amount.',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or investigator assigned to this claim.',
    `case_id` BIGINT COMMENT 'Foreign key linking to fraud.case. Business justification: A customer claim can escalate to or be associated with a formal fraud case. N:1 relationship. No bidirectional conflict (case does not have claim_id FK back). No columns to remove as claim tracks its ',
    `chargeback_id` BIGINT COMMENT 'External case identifier for the chargeback filed with the card network or payment processor.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: A customer claim can be linked to a specific fraud incident. N:1 relationship. No bidirectional conflict (fraud_incident does not have claim_id FK back). Claim tracks customer-initiated dispute, incid',
    `contact_center_id` BIGINT COMMENT 'Foreign key linking to channel.contact_center. Business justification: Customer fraud claims received via contact centers require linkage for Reg E compliance (claim receipt timestamp verification from call logs), call recording retention (legal hold for disputes), dispu',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Customer fraud claims on wealth accounts (disputed trades, unauthorized withdrawals, advisor misconduct) require portfolio linkage for investigation, provisional credit decisions, and final resolution',
    `party_id` BIGINT COMMENT 'Identifier of the customer who submitted the fraud claim.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each claim can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have claim_id FK back). Normalizing: fraud_typology (STRING) is replaced by FK to typolog',
    `attestation_date` DATE COMMENT 'Date the customer attestation or affidavit was received by the bank.',
    `chargeback_initiated` BOOLEAN COMMENT 'Indicates whether a chargeback was initiated with the card network or merchant acquirer as part of the claim resolution process.',
    `claim_number` STRING COMMENT 'Externally visible unique claim reference number assigned at intake for customer and regulatory tracking.. Valid values are `^CLM[0-9]{10}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the fraud claim in the investigation and resolution workflow. [ENUM-REF-CANDIDATE: received|under_investigation|pending_documentation|approved|denied|closed|withdrawn — 7 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the fraud claim based on the nature of the fraudulent activity reported by the customer.. Valid values are `unauthorized_transaction|identity_theft|account_takeover|card_fraud|check_fraud|wire_fraud`',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total monetary amount claimed by the customer as fraudulent or disputed, in the account currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud claim record was first created in the system.',
    `customer_attestation_received` BOOLEAN COMMENT 'Indicates whether the customer has provided a signed attestation or affidavit affirming the fraudulent nature of the transactions.',
    `customer_notification_date` DATE COMMENT 'Date the customer was notified of the claim resolution outcome.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether the customer was notified of the claim resolution outcome as required by consumer protection regulations.',
    `final_credit_confirmation_date` DATE COMMENT 'Date the provisional credit was confirmed as permanent following successful claim resolution.',
    `final_credit_confirmed` BOOLEAN COMMENT 'Indicates whether provisional credit has been converted to permanent credit following claim approval.',
    `investigation_completion_date` DATE COMMENT 'Date the fraud investigation was completed and a determination was made.',
    `investigation_start_date` DATE COMMENT 'Date the fraud investigation was formally initiated by the fraud operations team.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the fraud claim was referred.',
    `law_enforcement_case_number` STRING COMMENT 'Case number assigned by the law enforcement agency for tracking the criminal investigation.',
    `law_enforcement_referral` BOOLEAN COMMENT 'Indicates whether the fraud claim was referred to law enforcement for criminal investigation.',
    `loss_amount` DECIMAL(18,2) COMMENT 'Actual financial loss incurred by the bank as a result of the fraud claim, net of any recoveries.',
    `provisional_credit_amount` DECIMAL(18,2) COMMENT 'Amount of provisional credit issued to the customer pending investigation outcome, as required by consumer protection regulations.',
    `provisional_credit_issued_date` DATE COMMENT 'Date provisional credit was posted to the customer account, must comply with Regulation E 10-business-day rule or Regulation Z 5-business-day rule.',
    `provisional_credit_reversal_date` DATE COMMENT 'Date provisional credit was reversed from the customer account, typically when the claim is denied or investigation concludes the transaction was authorized.',
    `provisional_credit_reversal_reason` STRING COMMENT 'Business reason for reversing provisional credit, such as claim denial, customer withdrawal, or determination that transaction was authorized.',
    `receipt_date` DATE COMMENT 'Date the fraud claim was received from the customer, marking the start of regulatory timelines for provisional credit and investigation.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fraud claim was logged into the system, used for SLA tracking and audit trails.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudster, merchant, card network, or other parties through chargeback or legal action.',
    `recovery_date` DATE COMMENT 'Date recovery funds were received and posted.',
    `regulatory_basis` STRING COMMENT 'Regulatory rule under which provisional credit was issued: Regulation E 10-business-day rule for electronic fund transfers, Regulation Z 5-business-day rule for credit card disputes, or voluntary bank policy.. Valid values are `reg_e_10_day|reg_z_5_day|reg_e_45_day|voluntary|none`',
    `resolution_code` STRING COMMENT 'Final disposition code indicating the outcome of the fraud claim investigation.. Valid values are `approved_customer_favor|denied_authorized_transaction|denied_insufficient_evidence|withdrawn_by_customer|closed_duplicate`',
    `resolution_date` DATE COMMENT 'Date the fraud claim was formally resolved and closed.',
    `resolution_notes` STRING COMMENT 'Detailed narrative explanation of the investigation findings and resolution rationale, used for audit and quality assurance.',
    `sar_bsa_identifier` STRING COMMENT 'FinCEN BSA identifier assigned to the filed SAR.',
    `sar_filed` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN as a result of this fraud claim, as required by the Bank Secrecy Act.',
    `sar_filing_date` DATE COMMENT 'Date the SAR was filed with FinCEN.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud claim record was last modified.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Master entity representing a customer-initiated fraud claim or dispute submitted through any channel (branch, contact center, digital banking, written notice). Captures claim receipt date, channel, type (unauthorized transaction, identity theft, account takeover, card fraud), claimed amount, customer attestation status, and final resolution. Includes full provisional credit lifecycle tracking: provisional credit amount, issuance date, account credited, regulatory basis (Reg E 10-day rule, Reg Z 5-day rule), reversal date, reversal reason, and final credit confirmation status. Ensures compliance with Regulation E and Regulation Z consumer protection timelines. Distinct from chargeback — a claim is the customer-facing intake record; a chargeback is the network-level dispute.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`network_link` (
    `network_link_id` BIGINT COMMENT 'Primary key for network_link',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or investigator who validated and confirmed the network link relationship. Used for accountability and quality assurance.',
    `fraud_ring_id` BIGINT COMMENT 'Identifier of the organized fraud ring or network to which this link belongs. Groups multiple links into a cohesive fraud organization for investigation and prosecution.',
    `case_id` BIGINT COMMENT 'Identifier of the primary fraud case that led to the discovery of this network link. Links the relationship to the originating investigation.',
    `subject_id` BIGINT COMMENT 'Identifier of the originating fraud subject, account, device, or entity in the network relationship. References the source node in the fraud network graph.',
    `target_subject_id` BIGINT COMMENT 'Identifier of the destination fraud subject, account, device, or entity in the network relationship. References the target node in the fraud network graph.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last updated the network link record. Used for accountability and audit purposes.',
    `analyst_notes` STRING COMMENT 'Free-text notes and observations recorded by fraud analysts during the investigation of this network link. Contains investigative insights and follow-up actions.',
    `bidirectional_flag` BOOLEAN COMMENT 'Indicates whether the network link represents a bidirectional relationship (true) or a unidirectional relationship (false). Bidirectional links suggest mutual coordination.',
    `confirmation_date` DATE COMMENT 'Date when the network link was validated and confirmed by an analyst as a legitimate fraud relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the network link record was first created in the fraud case management system. Used for audit trail and data lineage.',
    `data_source_system` STRING COMMENT 'Name of the source system or platform that provided the data leading to the discovery of this network link (e.g., NICE Actimize, internal graph analytics, external intelligence feed).',
    `discovery_date` DATE COMMENT 'Date when the network link was first identified and recorded in the fraud case management system.',
    `discovery_method` STRING COMMENT 'Method by which the network link was identified and established. Indicates whether the relationship was discovered through automated systems, manual investigation, or external sources.. Valid values are `automated_graph_analysis|manual_investigation|tip_referral|cross_case_review|pattern_matching|external_intelligence`',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the network link was first identified, including time-of-day for audit trail and temporal analysis purposes.',
    `first_observed_date` DATE COMMENT 'Earliest date when the relationship between the linked subjects was first observed in transaction or behavioral data, prior to formal discovery.',
    `graph_visualization_metadata` STRING COMMENT 'JSON or XML metadata used by graph analytics platforms for network topology visualization, including node positioning, edge styling, and clustering information.',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation of this network link based on risk score, potential loss exposure, and regulatory urgency.. Valid values are `critical|high|medium|low`',
    `last_observed_date` DATE COMMENT 'Most recent date when the relationship between the linked subjects was observed in transaction or behavioral data, used to assess ongoing activity.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the network link evidence was referred (e.g., FBI, Secret Service, local police). Null if no referral made.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether this network link was included in a referral package to law enforcement agencies for criminal investigation or prosecution.',
    `link_evidence_description` STRING COMMENT 'Detailed narrative describing the specific evidence supporting the network link, including data points, patterns, and investigative findings used for SAR narratives and law enforcement referrals.',
    `link_expiration_date` DATE COMMENT 'Date when the network link is scheduled to expire or be archived if no further activity is observed. Used for data retention and case closure workflows.',
    `link_status` STRING COMMENT 'Current lifecycle status of the network link indicating whether the relationship is actively monitored, confirmed, or has been resolved.. Valid values are `active|inactive|under_review|confirmed|disputed|archived`',
    `link_strength_score` DECIMAL(18,2) COMMENT 'Quantitative measure of the confidence and strength of the network relationship, typically ranging from 0.00 to 100.00. Higher scores indicate stronger evidence of coordinated fraud activity.',
    `link_type` STRING COMMENT 'Classification of the relationship type between fraud subjects indicating the nature of the connection. [ENUM-REF-CANDIDATE: shared_device_fingerprint|shared_ip_address|shared_physical_address|shared_phone_number|common_beneficiary_account|mule_account_network|shared_employer|velocity_pattern_match|shared_email_domain|common_transaction_pattern — promote to reference product]. Valid values are `shared_device_fingerprint|shared_ip_address|shared_physical_address|shared_phone_number|common_beneficiary_account|mule_account_network`',
    `network_depth_level` STRING COMMENT 'Degree of separation from the primary fraud subject in the network graph. Level 1 indicates direct connection, higher levels indicate indirect relationships through intermediaries.',
    `observation_frequency` STRING COMMENT 'Number of times the relationship pattern has been observed across transactions, interactions, or events. Higher frequency indicates stronger coordination.',
    `referral_date` DATE COMMENT 'Date when the network link evidence was formally referred to law enforcement. Used for tracking investigation timelines.',
    `related_case_count` STRING COMMENT 'Number of fraud cases associated with this network link, indicating the breadth of coordinated fraud activity across multiple investigations.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score assessing the threat level posed by this network relationship, incorporating link strength, fraud typology severity, and historical loss patterns.',
    `sar_filing_date` DATE COMMENT 'Date when the SAR containing this network link was filed with FinCEN. Null if no SAR has been filed.',
    `sar_included_flag` BOOLEAN COMMENT 'Indicates whether this network link was included in a Suspicious Activity Report (SAR) filing to FinCEN. Used for regulatory compliance tracking.',
    `shared_attribute_value` DECIMAL(18,2) COMMENT 'The specific shared data element that establishes the link (e.g., IP address, device fingerprint hash, physical address, phone number). Stored in hashed or masked format for privacy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the network link record was last modified. Tracks changes to link status, strength score, or investigative findings.',
    CONSTRAINT pk_network_link PRIMARY KEY(`network_link_id`)
) COMMENT 'Association entity capturing identified relationships between fraud subjects, accounts, devices, and entities that indicate coordinated or organized fraud activity. Tracks link type (shared device fingerprint, shared IP address, shared physical address, shared phone number, common beneficiary account, mule account network, shared employer, velocity pattern match), link strength score, discovery method (automated graph analysis, manual investigation, tip/referral), discovery date, confirming analyst, and linkage to the fraud cases and subjects involved. Supports fraud ring detection and visualization, organized fraud investigation, Suspicious Activity Report narrative enrichment, and law enforcement referral evidence packages. Integrates with graph analytics platforms for network topology analysis.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`subject` (
    `subject_id` BIGINT COMMENT 'Unique identifier for the fraud subject entity. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Fraud subjects addresses require country validation for jurisdiction determination, sanctions screening (OFAC/EU), law enforcement referral routing, and cross-border fraud ring detection. Core fraud ',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for loss amounts associated with the fraud subject.',
    `employee_id` BIGINT COMMENT 'User identifier of the fraud investigator or system user who last updated the fraud subject record.',
    `fraud_ring_id` BIGINT COMMENT 'Identifier linking the fraud subject to a specific organized fraud ring or criminal network.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Fraud subjects may be issuers themselves (shell companies, fraudulent issuers, pump-and-dump operators). Links issuer entities to fraud subject records for issuer fraud tracking, sanctions screening, ',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each subject can be associated with a primary fraud typology. N:1 relationship. No bidirectional conflict (typology does not have subject_id FK back). Normalizing: fraud_typology (STRING) is replaced ',
    `address_line_1` STRING COMMENT 'First line of the physical address associated with the fraud subject including street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the physical address such as apartment or suite number.',
    `associated_account_numbers` STRING COMMENT 'Comma-separated list of bank account numbers associated with the fraud subject including mule accounts and compromised accounts.',
    `associated_device_ids` STRING COMMENT 'Comma-separated list of device identifiers such as IMEI, MAC addresses, or device fingerprints linked to the fraud subject.',
    `associated_ip_addresses` STRING COMMENT 'Comma-separated list of IP addresses used by the fraud subject during fraudulent activities.',
    `city` STRING COMMENT 'City or municipality of the fraud subject address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud subject record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the fraud subject used for identity verification and matching.',
    `drivers_license_number` STRING COMMENT 'Drivers license number of the fraud subject used for identity verification.',
    `email_address` STRING COMMENT 'Primary email address associated with the fraud subject as identified during investigation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_identified_date` DATE COMMENT 'Date when the fraud subject was first identified in the fraud management system.',
    `first_name` STRING COMMENT 'First name or given name of the fraud subject.',
    `fraud_ring_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the fraud subject is believed to be part of an organized fraud ring or syndicate.',
    `full_name` STRING COMMENT 'Complete legal or known name of the fraud subject as identified during investigation.',
    `investigation_notes` STRING COMMENT 'Free-text notes and observations from fraud investigators regarding the fraud subject including behavioral patterns, modus operandi, and investigative findings.',
    `known_aliases` STRING COMMENT 'Comma-separated list of known aliases, alternate names, or pseudonyms used by the fraud subject.',
    `last_activity_date` DATE COMMENT 'Date of the most recent fraudulent activity or case involvement associated with the fraud subject.',
    `last_name` STRING COMMENT 'Last name or surname of the fraud subject.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the fraud subject was referred such as FBI, Secret Service, or local police department.',
    `law_enforcement_case_number` STRING COMMENT 'Case number assigned by the law enforcement agency for tracking the investigation of the fraud subject.',
    `law_enforcement_referral_date` DATE COMMENT 'Date when the fraud subject was referred to law enforcement.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the fraud subject has been referred to law enforcement agencies for criminal investigation.',
    `middle_name` STRING COMMENT 'Middle name or initial of the fraud subject if available.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number such as Social Security Number (SSN), Tax Identification Number (TIN), or equivalent for the fraud subject.',
    `passport_number` STRING COMMENT 'Passport number of the fraud subject if available from investigation records.',
    `phone_number` STRING COMMENT 'Primary phone number associated with the fraud subject.',
    `postal_code` STRING COMMENT 'Postal code or ZIP code of the fraud subject address.',
    `prior_fraud_case_count` STRING COMMENT 'Number of prior fraud cases in which this subject has been identified or implicated.',
    `risk_score` STRING COMMENT 'Calculated risk score representing the threat level posed by the fraud subject based on historical activity, fraud typology, and loss amounts. Typically ranges from 0 to 100.',
    `risk_tier` STRING COMMENT 'Risk tier classification of the fraud subject based on risk score and threat assessment.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'State, province, or region of the fraud subject address.',
    `subject_status` STRING COMMENT 'Current status of the fraud subject in the fraud management system indicating their investigation or monitoring state.. Valid values are `active|inactive|watchlist|law_enforcement_referred|cleared|deceased`',
    `subject_type` STRING COMMENT 'Classification of the fraud subject indicating their relationship to the bank: internal employee, external third party, customer, organized fraud ring member, mule account holder, or unknown.. Valid values are `internal_employee|external_third_party|customer|organized_fraud_ring_member|unknown|mule_account_holder`',
    `total_confirmed_loss_amount` DECIMAL(18,2) COMMENT 'Cumulative confirmed financial loss across all fraud cases involving this subject.',
    `total_estimated_loss_amount` DECIMAL(18,2) COMMENT 'Cumulative estimated financial loss across all fraud cases involving this subject.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud subject record was last updated.',
    `watchlist_status` STRING COMMENT 'Indicates whether the fraud subject is on any internal or external watchlist including law enforcement, industry fraud databases, or sanctions lists.. Valid values are `not_on_watchlist|internal_watchlist|law_enforcement_watchlist|industry_watchlist|sanctions_list`',
    CONSTRAINT pk_subject PRIMARY KEY(`subject_id`)
) COMMENT 'Master entity representing individuals or entities identified as subjects of fraud investigations — including perpetrators, mule account holders, and suspected organized fraud ring members. Captures subject type (internal employee, external third party, customer, unknown), subject identification details, known aliases, associated accounts and devices, watchlist status, law enforcement referral status, and prior fraud history. Distinct from the customer master — a fraud subject may not be a bank customer and may represent an external threat actor.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` (
    `law_enforcement_referral_id` BIGINT COMMENT 'Unique identifier for the law enforcement referral record.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the loss amounts.',
    `case_id` BIGINT COMMENT 'Foreign key reference to the originating fraud case that triggered this law enforcement referral.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the bank liaison responsible for coordinating this referral.',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to fraud.sar_filing. Business justification: A law enforcement referral may be associated with a SAR filing. N:1 relationship. No bidirectional conflict (sar_filing does not have law_enforcement_referral_id FK back). The existing sar_reference_n',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each law enforcement referral can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have law_enforcement_referral_id FK back). Normalizing: fraud_typology',
    `acknowledgment_received_date` DATE COMMENT 'Date when acknowledgment of receipt was received from the law enforcement agency.',
    `agency_case_number` STRING COMMENT 'Case number or reference identifier assigned by the receiving law enforcement agency.',
    `agency_contact_email` STRING COMMENT 'Email address of the law enforcement contact for this referral.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Name of the law enforcement officer or agent who is the primary contact for this referral.',
    `agency_contact_phone` STRING COMMENT 'Phone number of the law enforcement contact for this referral.',
    `bank_liaison_email` STRING COMMENT 'Email address of the bank liaison for law enforcement coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_liaison_name` STRING COMMENT 'Name of the bank employee serving as the primary liaison for this law enforcement referral.',
    `bank_liaison_phone` STRING COMMENT 'Phone number of the bank liaison for law enforcement coordination.',
    `closed_date` DATE COMMENT 'Date when the law enforcement referral was formally closed.',
    `closure_reason` STRING COMMENT 'Explanation for why the law enforcement referral was closed.',
    `confidentiality_level` STRING COMMENT 'Classification level for the sensitivity and confidentiality of this referral.. Valid values are `public|internal|confidential|restricted`',
    `confirmed_loss_amount` DECIMAL(18,2) COMMENT 'Confirmed financial loss amount associated with the fraud case being referred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this law enforcement referral record was first created in the system.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Estimated financial loss amount associated with the fraud case being referred.',
    `evidence_package_reference` STRING COMMENT 'Reference identifier for the evidence package or documentation bundle submitted with this referral.',
    `evidence_submission_method` STRING COMMENT 'Method used to transmit evidence and documentation to the law enforcement agency.. Valid values are `secure_portal|encrypted_email|physical_delivery|secure_file_transfer|in_person`',
    `investigation_outcome` STRING COMMENT 'Final outcome of the law enforcement investigation resulting from this referral. [ENUM-REF-CANDIDATE: arrest_made|charges_filed|case_declined|investigation_ongoing|case_closed_no_action|prosecution_successful|prosecution_unsuccessful|restitution_ordered|plea_agreement|trial_verdict — promote to reference product]',
    `investigation_status_update` STRING COMMENT 'Latest status update received from law enforcement regarding their investigation.',
    `legal_obligation_flag` BOOLEAN COMMENT 'Indicates whether this referral is made under a legal or regulatory obligation (True) or is voluntary (False).',
    `notes` STRING COMMENT 'Free-text notes and additional details regarding the law enforcement referral.',
    `prosecution_initiated_flag` BOOLEAN COMMENT 'Indicates whether criminal prosecution was initiated as a result of this referral.',
    `receiving_agency_name` STRING COMMENT 'Name of the law enforcement agency receiving the referral (e.g., FBI, Secret Service, local police department).',
    `receiving_agency_type` STRING COMMENT 'Classification of the law enforcement agency by jurisdictional level.. Valid values are `federal|state|local|international`',
    `referral_date` DATE COMMENT 'Date when the referral was formally submitted to the law enforcement agency.',
    `referral_number` STRING COMMENT 'Business identifier for the law enforcement referral, used for external communication and tracking.',
    `referral_priority` STRING COMMENT 'Priority level assigned to this law enforcement referral based on severity and urgency.. Valid values are `critical|high|medium|low`',
    `referral_reason` STRING COMMENT 'Detailed explanation of why this case is being referred to law enforcement.',
    `referral_status` STRING COMMENT 'Current lifecycle status of the law enforcement referral.. Valid values are `draft|submitted|acknowledged|under_investigation|closed|withdrawn`',
    `referral_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the referral was submitted to the law enforcement agency.',
    `referral_type` STRING COMMENT 'Classification of the type of law enforcement referral being made.. Valid values are `criminal_complaint|subpoena_response|voluntary_disclosure|information_sharing|grand_jury_subpoena|search_warrant_response`',
    `response_due_date` DATE COMMENT 'Date by which the bank must respond to the law enforcement request or complete the referral.',
    `restitution_amount` DECIMAL(18,2) COMMENT 'Amount of restitution ordered by the court as a result of prosecution stemming from this referral.',
    `restitution_received_amount` DECIMAL(18,2) COMMENT 'Amount of court-ordered restitution actually received by the bank.',
    `sar_reference_number` STRING COMMENT 'Reference number of the associated Suspicious Activity Report if one was filed in connection with this referral.',
    `subpoena_number` STRING COMMENT 'Official number or identifier of the subpoena if this referral is in response to a subpoena.',
    `subpoena_received_date` DATE COMMENT 'Date when the subpoena was received by the bank.',
    `subpoena_received_flag` BOOLEAN COMMENT 'Indicates whether this referral was triggered by receipt of a subpoena from law enforcement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this law enforcement referral record was last updated.',
    CONSTRAINT pk_law_enforcement_referral PRIMARY KEY(`law_enforcement_referral_id`)
) COMMENT 'Transactional entity capturing formal referrals made to law enforcement agencies (FBI, Secret Service, local police) arising from confirmed fraud cases. Tracks referral date, receiving agency, agency case number, referral type (criminal complaint, subpoena response, voluntary disclosure), evidence package reference, bank liaison contact, referral status, and outcome. Supports the banks legal and compliance obligations for reporting fraud to law enforcement and responding to law enforcement requests.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`device_fingerprint` (
    `device_fingerprint_id` BIGINT COMMENT 'Unique identifier for the device fingerprint record. Primary key.',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Device fingerprinting is performed during customer sessions. Linking enables real-time fraud scoring during active sessions, session replay analysis post-fraud, behavioral biometrics correlation, and ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Device geolocation enables geographic velocity checks (impossible travel), sanctions screening, high-risk jurisdiction flagging, and cross-border fraud detection. Essential for digital fraud preventio',
    `associated_account_count` STRING COMMENT 'Number of distinct accounts that have been accessed from this device fingerprint. Abnormally high counts may indicate account takeover activity.',
    `associated_party_count` STRING COMMENT 'Number of distinct customer or party identifiers that have used this device fingerprint. High counts may indicate shared devices or fraud rings.',
    `blacklist_date` DATE COMMENT 'Date when the device was added to the blacklist. Null if not blacklisted.',
    `blacklist_reason` STRING COMMENT 'Business reason or fraud typology that caused the device to be blacklisted (e.g., account takeover, card-not-present fraud, multiple failed authentication attempts).',
    `blacklist_status` STRING COMMENT 'Indicates whether the device is on a fraud blacklist, watchlist, or whitelist for monitoring and blocking purposes.. Valid values are `not_blacklisted|blacklisted|watchlist|whitelisted`',
    `browser_name` STRING COMMENT 'Name of the web browser used for digital channel access (e.g., Chrome, Safari, Firefox, Edge). Null for non-browser devices.',
    `browser_version` STRING COMMENT 'Version number of the browser used. Null for non-browser devices.',
    `cookie_enabled_flag` BOOLEAN COMMENT 'Indicates whether cookies are enabled on the device browser. False may indicate privacy tools or fraud evasion techniques.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this device fingerprint record was first created in the fraud management system.',
    `data_source_system` STRING COMMENT 'Name of the source system or fraud detection platform that captured this device fingerprint (e.g., NICE Actimize, ThreatMetrix, Kount).',
    `device_identifier` STRING COMMENT 'Unique device identifier such as IMEI, MAC address, or vendor-assigned device ID used to track the physical device across sessions.',
    `device_reputation_score` DECIMAL(18,2) COMMENT 'Aggregated reputation score (0-100) based on historical behavior, fraud incidents, and third-party threat intelligence feeds. Lower scores indicate higher risk.',
    `device_type` STRING COMMENT 'Classification of the device used for the transaction or session.. Valid values are `mobile|desktop|tablet|atm_terminal|pos_terminal|kiosk`',
    `emulator_indicator` BOOLEAN COMMENT 'Flag indicating whether the device appears to be an emulator rather than a physical device, often used in automated fraud attacks.',
    `fingerprint_hash` STRING COMMENT 'Cryptographic hash representing the unique combination of device attributes (browser, OS, screen resolution, plugins, fonts, timezone) used for device identification and fraud detection.',
    `first_seen_timestamp` TIMESTAMP COMMENT 'Date and time when this device fingerprint was first observed in the banking system.',
    `fraud_case_count` STRING COMMENT 'Total number of confirmed fraud cases associated with this device fingerprint.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0-100) assigned by the fraud detection engine based on device behavior, velocity, and historical fraud patterns. Higher scores indicate higher fraud risk.',
    `fraud_typology` STRING COMMENT 'Primary fraud typology associated with this device (e.g., account takeover, card-not-present fraud, synthetic identity fraud, wire fraud). [ENUM-REF-CANDIDATE: account_takeover|card_not_present|synthetic_identity|wire_fraud|check_fraud|phishing|social_engineering|insider_fraud — promote to reference product]',
    `geolocation_city` STRING COMMENT 'City name derived from IP geolocation or device GPS coordinates.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the device location at time of fingerprint capture.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the device location at time of fingerprint capture.',
    `ip_address` STRING COMMENT 'IP address from which the device connected to banking services. Used for geolocation and fraud pattern analysis.',
    `javascript_enabled_flag` BOOLEAN COMMENT 'Indicates whether JavaScript is enabled on the device browser. Disabled JavaScript may indicate bot activity or fraud evasion.',
    `language_preference` STRING COMMENT 'Preferred language setting of the device or browser (e.g., en-US, es-ES, fr-FR).',
    `last_fraud_alert_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent fraud alert was triggered for activity from this device.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Date and time when this device fingerprint was most recently observed in an active session or transaction.',
    `operating_system` STRING COMMENT 'Operating system running on the device (e.g., iOS 16.2, Android 13, Windows 11, macOS Ventura).',
    `proxy_vpn_indicator` BOOLEAN COMMENT 'Flag indicating whether the device is connecting through a proxy server or VPN, which may indicate location masking or fraud.',
    `risk_score_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud risk score was last calculated or updated.',
    `rooted_jailbroken_indicator` BOOLEAN COMMENT 'Flag indicating whether the mobile device has been rooted (Android) or jailbroken (iOS), which increases fraud risk by bypassing security controls.',
    `screen_resolution` STRING COMMENT 'Screen resolution of the device in pixels (e.g., 1920x1080, 2560x1440) used as part of device fingerprinting.',
    `timezone_offset` STRING COMMENT 'Timezone offset from UTC reported by the device (e.g., -05:00, +01:00) used to detect location spoofing.',
    `tor_network_indicator` BOOLEAN COMMENT 'Flag indicating whether the device is connecting through the TOR anonymity network, a high-risk indicator for fraud.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this device fingerprint record was last updated with new attributes or risk scores.',
    `user_agent_string` STRING COMMENT 'Full HTTP user agent string provided by the browser or application, containing detailed device and software information.',
    `velocity_24h_transaction_count` STRING COMMENT 'Number of transactions initiated from this device in the last 24 hours. Used for velocity-based fraud detection rules.',
    `velocity_7d_login_count` STRING COMMENT 'Number of login attempts from this device in the last 7 days. High counts may indicate credential stuffing or brute force attacks.',
    CONSTRAINT pk_device_fingerprint PRIMARY KEY(`device_fingerprint_id`)
) COMMENT 'Master entity capturing device fingerprint records used in fraud detection and digital channel authentication. Tracks device identifier, type (mobile, desktop, tablet, ATM terminal, POS terminal), operating system, browser fingerprint hash, IP address, geolocation, first and last seen dates, fraud engine risk score, and blacklist status. Supports device-based fraud detection for account takeover and card-not-present fraud, and feeds fraud network link analysis for identifying shared-device patterns across subjects.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`fraud_watchlist` (
    `fraud_watchlist_id` BIGINT COMMENT 'Unique identifier for the fraud watchlist entry.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Watchlist entries scope geographic applicability for matching rules, jurisdiction-specific blocking, and country-level fraud trend analysis. Core fraud prevention control. New FK replaces denormalized',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the estimated loss amount.',
    `subject_id` BIGINT COMMENT 'Foreign key linking to fraud.subject. Business justification: A watchlist entry can be for a specific fraud subject (individual or entity under investigation). N:1 relationship. No bidirectional conflict (subject does not have fraud_watchlist_id FK back). Watchl',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities watchlists for restricted trading (market manipulation suspects, sanctioned instruments, grey market securities) require instrument linkage for pre-trade compliance checks, order blocking, ',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Watchlisted entities include investor accounts flagged for suspicious activity (prior fraud, AML concerns, sanctions screening hits). Fraud prevention and transaction monitoring systems use watchlists',
    `case_id` BIGINT COMMENT 'Reference to the fraud case investigation that resulted in this watchlist entry being created.',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or system user who created this watchlist entry.',
    `tertiary_fraud_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last updated this watchlist record.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each watchlist entry can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have fraud_watchlist_id FK back). Normalizing: fraud_typology (STRING) is repla',
    `action_tier` STRING COMMENT 'Operational action to be taken when this watchlist entry is matched: monitor only (log and alert), enhanced authentication required (step-up verification), transaction restrict (limit transaction types or amounts), or hard block (prevent all activity).. Valid values are `monitor_only|enhanced_authentication|transaction_restrict|hard_block`',
    `confidence_level` STRING COMMENT 'Assessed confidence in the accuracy and reliability of the watchlist entry based on evidence quality and source credibility: high (confirmed fraud with strong evidence), medium (suspected fraud with supporting indicators), or low (precautionary based on weak signals).. Valid values are `high|medium|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this watchlist record was first created in the system.',
    `entry_date` DATE COMMENT 'Date when the entity was added to the fraud watchlist.',
    `entry_number` STRING COMMENT 'Business-facing unique identifier for the watchlist entry, formatted as WL- followed by 10 digits.. Valid values are `^WL-[0-9]{10}$`',
    `entry_type` STRING COMMENT 'Type of entity being watchlisted: customer (individual or corporate party), account number, device fingerprint, merchant ID, IP address range, or BIN (Bank Identification Number) range.. Valid values are `customer|account_number|device_fingerprint|merchant_id|ip_address_range|bin_range`',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Estimated or confirmed financial loss amount associated with the fraud activity that led to this watchlist entry.',
    `expiry_date` DATE COMMENT 'Date when the watchlist entry is scheduled to expire and be automatically removed or flagged for review. Null indicates indefinite watchlist status.',
    `geographic_scope` STRING COMMENT 'Geographic applicability of the watchlist entry: global (applies to all jurisdictions), regional (applies to specific regions), or country specific (applies to specific countries only).. Valid values are `global|regional|country_specific`',
    `industry_sharing_flag` BOOLEAN COMMENT 'Indicates whether this watchlist entry has been shared with industry fraud consortiums or information sharing networks.',
    `last_match_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction or event that matched this watchlist entry during screening.',
    `last_review_date` DATE COMMENT 'Date when the watchlist entry was most recently reviewed by a fraud analyst or automated review process.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency that was notified or is investigating the fraud associated with this watchlist entry.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement agencies have been notified about the fraud activity associated with this watchlist entry.',
    `match_count` STRING COMMENT 'Number of times this watchlist entry has been matched during real-time transaction screening or account opening risk assessment since it was added.',
    `notes` STRING COMMENT 'Free-text field for additional context, investigation notes, or operational guidance related to this watchlist entry.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the entity was added to the watchlist: confirmed fraud (proven fraud case), suspected fraud (under investigation), industry intelligence (shared from external sources), synthetic identity, account takeover, or chargeback abuse.. Valid values are `confirmed_fraud|suspected_fraud|industry_intelligence|synthetic_identity|account_takeover|chargeback_abuse`',
    `reason_description` STRING COMMENT 'Detailed narrative explaining the specific circumstances and evidence that led to the watchlist entry.',
    `removal_date` DATE COMMENT 'Date when the watchlist entry was removed from active status.',
    `removal_reason` STRING COMMENT 'Explanation for why the watchlist entry was removed or expired, including false positive determination, case closure, or time-based expiration.',
    `review_date` DATE COMMENT 'Date when the watchlist entry is scheduled for periodic review to determine if it should remain active, be escalated, or be removed.',
    `review_status` STRING COMMENT 'Current lifecycle status of the watchlist entry: active (in force), under review (being evaluated for continuation), expired (past expiry date but not yet removed), or removed (no longer active).. Valid values are `active|under_review|expired|removed`',
    `sar_reference_number` STRING COMMENT 'Reference number of the SAR (Suspicious Activity Report) filed with FinCEN (Financial Crimes Enforcement Network) related to this watchlist entry, if applicable.',
    `severity_score` STRING COMMENT 'Numeric score (1-100) representing the severity and risk level of the fraud associated with this watchlist entry, with higher scores indicating greater risk.',
    `sharing_network` STRING COMMENT 'Name of the fraud information sharing network or consortium where this watchlist entry was shared or received from (e.g., FS-ISAC, regional banking fraud networks).',
    `source_system` STRING COMMENT 'Origin of the watchlist intelligence: internal investigation (from banks own fraud cases), industry sharing (from financial crime consortiums), law enforcement (from regulatory or police agencies), or third party intelligence (from commercial fraud data providers).. Valid values are `internal_investigation|industry_sharing|law_enforcement|third_party_intelligence`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this watchlist record was last modified.',
    `watchlisted_value` DECIMAL(18,2) COMMENT 'The actual value being watchlisted (e.g., customer ID, account number, device hash, merchant identifier, IP range CIDR, BIN range). Format varies by entry_type.',
    CONSTRAINT pk_fraud_watchlist PRIMARY KEY(`fraud_watchlist_id`)
) COMMENT 'Master entity maintaining the banks internal fraud watchlist of high-risk individuals, accounts, devices, merchants, and entities identified through prior fraud investigations and industry intelligence sharing. Captures watchlist entry type (customer, account number, device fingerprint, merchant ID, IP address range, BIN range, email domain), watchlist reason code, entry date, expiry/review date, watchlist action tier (monitor-only, enhanced authentication required, transaction restrict, hard block), originating fraud case reference, adding analyst, last review date, and review status (active, under review, expired, removed). Distinct from OFAC/sanctions screening watchlists owned by the compliance domain — this is the fraud-specific internal watchlist used for real-time transaction screening and account opening risk assessment.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`typology` (
    `typology_id` BIGINT COMMENT 'Unique identifier for the fraud typology classification. Primary key for the fraud typology master reference table.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for loss amount fields. Typically USD for US-based institutions.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the fraud risk manager or subject matter expert responsible for maintaining this typology definition and associated controls.',
    `universe_id` BIGINT COMMENT 'Foreign key linking to audit.audit_universe. Business justification: Fraud typologies inform audit universe risk assessment. Banking operations use fraud risk taxonomy to prioritize audit coverage, requiring linkage from typology to audit universe entity for risk-based',
    `parent_typology_id` BIGINT COMMENT 'Self-referencing FK on typology (parent_typology_id)',
    `attack_vector` STRING COMMENT 'Primary method or technique used by fraudsters to execute this typology (e.g., phishing, social engineering, malware, credential stuffing, SIM swap, insider collusion).',
    `average_loss_amount` DECIMAL(18,2) COMMENT 'Mean financial loss per incident for this fraud typology based on historical case data. Used for risk quantification and capital allocation under operational risk frameworks.',
    `basel_event_type_code` STRING COMMENT 'Basel II/III operational risk event type classification (1=Internal Fraud, 2=External Fraud, 3=Employment Practices, 4=Clients Products Business Practices, 5=Damage to Physical Assets, 6=Business Disruption and System Failures, 7=Execution Delivery Process Management). Most fraud typologies map to type 2 (External Fraud) or type 1 (Internal Fraud).. Valid values are `^[1-7]$`',
    `chargeback_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fraud typology is eligible for chargeback recovery through card network dispute processes (applicable primarily to card fraud typologies).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this fraud typology record was first created in the fraud management system.',
    `cross_border_indicator` BOOLEAN COMMENT 'Indicates whether this fraud typology typically involves cross-border transactions or international actors, requiring coordination with foreign law enforcement or financial intelligence units.',
    `customer_reimbursement_policy` STRING COMMENT 'Standard policy for customer reimbursement when this fraud typology occurs. Reflects regulatory requirements (e.g., Regulation E for unauthorized electronic transfers) and bank policy.. Valid values are `full_reimbursement|conditional_reimbursement|no_reimbursement|case_by_case`',
    `customer_segment` STRING COMMENT 'Primary customer segment affected by this fraud typology for risk profiling and control design.. Valid values are `retail|commercial|wealth|institutional|all`',
    `detection_difficulty_score` STRING COMMENT 'Numeric score (1-10) representing the difficulty of detecting this fraud typology, where 1 is easily detected and 10 is extremely difficult. Used for control effectiveness assessment and resource allocation.',
    `detection_method_primary` STRING COMMENT 'Most effective detection method or control for identifying this fraud typology (e.g., transaction monitoring rule, machine learning model, customer report, manual review, third-party alert).',
    `detection_method_secondary` STRING COMMENT 'Alternative or supplementary detection method used to identify this fraud typology. Supports layered defense strategy.',
    `effective_date` DATE COMMENT 'Date when this fraud typology classification became effective in the banks fraud management system.',
    `expiration_date` DATE COMMENT 'Date when this fraud typology classification was deprecated or superseded. Null for active typologies.',
    `incident_volume_12m` STRING COMMENT 'Total number of confirmed fraud incidents of this typology in the trailing 12 months. Key performance indicator for fraud risk monitoring.',
    `industry_prevalence_rank` STRING COMMENT 'Ranking of this fraud typology by prevalence across the banking industry (1 = most common). Based on industry reports and peer benchmarking.',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether losses from this fraud typology are covered under the banks fidelity bond, cyber insurance, or other insurance policies.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this fraud typology definition, risk assessment, and control effectiveness.',
    `law_enforcement_referral_recommended_flag` BOOLEAN COMMENT 'Indicates whether incidents of this fraud typology should be routinely referred to law enforcement based on severity, organized crime indicators, or regulatory expectations.',
    `maximum_observed_loss` DECIMAL(18,2) COMMENT 'Largest single loss amount recorded for this fraud typology. Used for tail risk assessment and stress testing.',
    `median_loss_amount` DECIMAL(18,2) COMMENT 'Median financial loss per incident for this fraud typology. Provides a more robust central tendency measure when loss distributions are skewed.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this fraud typology. Ensures taxonomy remains current with evolving threat landscape.',
    `organized_crime_indicator` BOOLEAN COMMENT 'Indicates whether this fraud typology is commonly associated with organized fraud rings or criminal enterprises rather than individual opportunistic actors.',
    `prevention_control_primary` STRING COMMENT 'Most effective preventive control or countermeasure for this fraud typology (e.g., multi-factor authentication, velocity limits, device fingerprinting, customer education, enhanced due diligence).',
    `prevention_control_secondary` STRING COMMENT 'Supplementary preventive control providing defense-in-depth against this fraud typology.',
    `recovery_rate_percent` DECIMAL(18,2) COMMENT 'Historical percentage of losses recovered through chargeback, insurance, legal action, or other means for this fraud typology. Used for net loss forecasting.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether incidents of this fraud typology trigger mandatory regulatory reporting obligations (e.g., SAR filing, CTR, data breach notification).',
    `risk_severity_tier` STRING COMMENT 'Enterprise risk classification tier for this fraud typology based on potential financial impact, reputational damage, and regulatory exposure.. Valid values are `critical|high|medium|low`',
    `sar_filing_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum loss amount that triggers mandatory SAR filing for this fraud typology. Typically $5,000 for most fraud types per FinCEN guidance, but may vary by typology.',
    `sophistication_level` STRING COMMENT 'Assessment of the technical and operational sophistication required by fraudsters to execute this typology. Informs threat intelligence and control design.. Valid values are `basic|intermediate|advanced|expert`',
    `subcategory` STRING COMMENT 'Detailed sub-classification within the typology category providing granular segmentation (e.g., Card Present vs Card Not Present within card fraud).',
    `target_channel` STRING COMMENT 'Primary banking channel or touchpoint targeted by this fraud typology (e.g., online banking, mobile app, ATM, branch, call center, wire transfer system).',
    `target_product_line` STRING COMMENT 'Banking product or service line most commonly targeted by this fraud typology (e.g., deposit accounts, credit cards, commercial lending, wealth management, payment services).',
    `total_loss_amount_12m` DECIMAL(18,2) COMMENT 'Aggregate confirmed loss amount for this fraud typology in the trailing 12 months. Used for operational risk capital calculation and management reporting.',
    `trend_direction` STRING COMMENT 'Current trend direction for incident volume and loss amounts for this fraud typology based on recent historical analysis. Used for strategic planning and resource allocation.. Valid values are `increasing|stable|decreasing|emerging|declining`',
    `typology_category` STRING COMMENT 'High-level classification grouping of the fraud typology for strategic analysis and reporting. [ENUM-REF-CANDIDATE: card_fraud|account_fraud|wire_fraud|ach_fraud|check_fraud|identity_theft|internal_fraud|cyber_fraud|loan_fraud|deposit_fraud — 10 candidates stripped; promote to reference product]',
    `typology_code` STRING COMMENT 'Standardized short code identifying the fraud typology (e.g., ACH-FRAUD, CARD-CNP, WIRE-BEC). Used for system integration and reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `typology_description` STRING COMMENT 'Comprehensive business description of the fraud typology including typical modus operandi, victim profile, and distinguishing characteristics. Used for investigator training and case classification.',
    `typology_name` STRING COMMENT 'Full business name of the fraud typology (e.g., Account Takeover, Business Email Compromise, Card Not Present Fraud).',
    `typology_status` STRING COMMENT 'Current lifecycle status of this fraud typology classification in the banks taxonomy. Deprecated typologies are retained for historical analysis but not used for new cases.. Valid values are `active|deprecated|emerging|under_review`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this fraud typology record was last modified. Used for change tracking and audit trail.',
    CONSTRAINT pk_typology PRIMARY KEY(`typology_id`)
) COMMENT 'Master classification of fraud types and attack patterns recognized by the bank. Captures typology code, description, risk indicators, detection methods, and loss trend data.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`loss` (
    `loss_id` BIGINT COMMENT 'Unique identifier for the fraud loss ledger record. Primary key.',
    `deposit_account_id` BIGINT COMMENT 'Reference to the account from which the fraud loss originated, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Operational loss allocation to cost centers is mandatory for management reporting, profitability analysis, transfer pricing, and Basel II/III operational risk capital calculations by business line. Ba',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the loss and recovery amounts.',
    `employee_id` BIGINT COMMENT 'Reference to the fraud investigator or analyst responsible for managing the loss recovery process.',
    `case_id` BIGINT COMMENT 'Reference to the fraud case that resulted in this confirmed loss event.',
    `fraud_incident_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_incident. Business justification: A loss record can be linked to the specific fraud incident that caused the financial loss. N:1 relationship. No bidirectional conflict (fraud_incident does not have loss_id FK back). Loss tracks finan',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fraud losses must be posted to specific GL accounts for financial statement impact, regulatory capital calculations (CCAR/DFAST operational risk), Basel event type reporting, and audit trail. The gl_a',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Fraud losses occur in investor accounts (unauthorized redemptions, forged switch instructions, identity takeover). Loss accounting and recovery processes require direct linkage to investor accounts fo',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Fraud losses are operational risk losses that must be captured in the operational risk event database for Basel regulatory capital calculation (SMA approach uses 15-year loss history). Required for CC',
    `party_id` BIGINT COMMENT 'Reference to the customer or party associated with the fraud loss event, if applicable.',
    `account_transaction_id` BIGINT COMMENT 'Reference to the specific transaction that resulted in the fraud loss, if applicable.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each loss can be classified by fraud typology. N:1 relationship. No bidirectional conflict (typology does not have loss_id FK back). Normalizing: fraud_typology (STRING) is replaced by FK to typology ',
    `reversal_fraud_loss_id` BIGINT COMMENT 'Self-referencing FK on loss (reversal_fraud_loss_id)',
    `basel_event_type_code` STRING COMMENT 'Basel II/III operational risk event type code (e.g., ET1 for Internal Fraud, ET2 for External Fraud) used for regulatory capital calculation and reporting.',
    `business_line` STRING COMMENT 'The line of business (LOB) where the fraud loss occurred, such as Retail Banking, Investment Banking, Wealth Management, or Treasury.',
    `ccar_loss_event_flag` BOOLEAN COMMENT 'Indicates whether this fraud loss event is material enough to be included in CCAR stress testing and capital planning submissions.',
    `chargeback_reference_number` STRING COMMENT 'Reference number for any chargeback initiated to recover the fraud loss from merchants or card networks.',
    `closed_timestamp` TIMESTAMP COMMENT 'The timestamp when the fraud loss case was closed, either through full recovery, write-off, or final disposition.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fraud loss record was first created in the system.',
    `discovery_date` DATE COMMENT 'The date when the fraud loss was first discovered or identified by the institution.',
    `event_number` STRING COMMENT 'Business-facing unique identifier for the loss event, used for tracking and reporting purposes.',
    `gl_posting_reference` STRING COMMENT 'Reference number or identifier for the general ledger journal entry that recorded this fraud loss.',
    `gross_loss_amount` DECIMAL(18,2) COMMENT 'The total confirmed financial loss amount before any recoveries or offsets.',
    `insurance_claim_number` STRING COMMENT 'Reference number for any insurance claim filed to recover the fraud loss.',
    `insurance_recovery_amount` DECIMAL(18,2) COMMENT 'The amount recovered specifically through insurance claims, if applicable.',
    `legal_case_number` STRING COMMENT 'Reference number for any legal proceedings or litigation related to the fraud loss recovery.',
    `loss_category` STRING COMMENT 'Classification of the fraud loss by type or origin, aligned with operational risk taxonomy.. Valid values are `internal_fraud|external_fraud|card_fraud|wire_fraud|ach_fraud|check_fraud`',
    `loss_date` DATE COMMENT 'The date when the fraud loss event occurred or was realized.',
    `loss_description` STRING COMMENT 'Detailed narrative description of the fraud loss event, including circumstances, impact, and any relevant context.',
    `loss_status` STRING COMMENT 'Current status of the fraud loss in the recovery and accounting lifecycle.. Valid values are `confirmed|under_review|partially_recovered|fully_recovered|written_off`',
    `net_loss_amount` DECIMAL(18,2) COMMENT 'The net financial loss after deducting all recoveries from the gross loss amount (gross_loss_amount minus recovery_amount).',
    `recovery_amount` DECIMAL(18,2) COMMENT 'The total amount recovered from insurance claims, chargebacks, legal proceedings, or other recovery methods.',
    `recovery_date` DATE COMMENT 'The date when recovery funds were received or credited, if applicable.',
    `recovery_method` STRING COMMENT 'The primary method used to recover funds from the fraud loss event.. Valid values are `insurance|chargeback|legal_action|customer_reimbursement|collateral_liquidation|none`',
    `recovery_notes` STRING COMMENT 'Free-text notes documenting recovery efforts, outcomes, and any challenges encountered during the recovery process.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this fraud loss must be included in regulatory reporting submissions such as CCAR, DFAST, or operational risk capital calculations.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report was filed with FinCEN for this fraud loss event.',
    `sar_filing_date` DATE COMMENT 'The date when the Suspicious Activity Report was filed with FinCEN, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fraud loss record was last modified or updated.',
    `write_off_approval_authority` STRING COMMENT 'The name or title of the authority who approved the write-off of the unrecovered fraud loss.',
    `write_off_date` DATE COMMENT 'The date when the unrecovered portion of the fraud loss was written off as uncollectible.',
    CONSTRAINT pk_loss PRIMARY KEY(`loss_id`)
) COMMENT 'Fraud loss ledger record capturing confirmed financial losses from fraud events. Tracks gross loss, recovered amount, net loss, loss category, and GL posting reference.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`rule_performance` (
    `rule_performance_id` BIGINT COMMENT 'Unique identifier for the fraud rule performance measurement record.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for monetary amounts in this performance record.',
    `detection_rule_id` BIGINT COMMENT 'Reference to the fraud detection rule or machine learning model being measured.',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst or data scientist who performed the rule tuning.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Rule performance can be measured per fraud typology. N:1 relationship. No bidirectional conflict (typology does not have rule_performance_id FK back). Normalizing: fraud_typology (STRING) is replaced ',
    `previous_rule_performance_id` BIGINT COMMENT 'Self-referencing FK on rule_performance (previous_rule_performance_id)',
    `alert_review_time_avg_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes required for analysts to review and disposition alerts from this rule.',
    `alert_volume` STRING COMMENT 'Total number of fraud alerts generated by this rule during the measurement period.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the tuning adjustment requires management approval before implementation.',
    `approval_status` STRING COMMENT 'Current approval status of the tuning adjustment.. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the tuning adjustment was approved.',
    `average_fraud_loss_per_alert` DECIMAL(18,2) COMMENT 'Mean fraud loss amount per true positive alert generated by this rule.',
    `case_conversion_rate` DECIMAL(18,2) COMMENT 'Proportion of alerts that were escalated to formal fraud investigation cases.',
    `channel_applicability` STRING COMMENT 'Banking channels where this rule is applied (e.g., online, mobile, ATM, branch).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this performance measurement record was first created.',
    `current_threshold_value` DECIMAL(18,2) COMMENT 'The threshold value after tuning adjustment was applied.',
    `detection_rate` DECIMAL(18,2) COMMENT 'Overall effectiveness of the rule in identifying fraud, expressed as a percentage of total fraud cases detected.',
    `effectiveness_score` DECIMAL(18,2) COMMENT 'Composite score measuring overall rule effectiveness, balancing detection rate and false positive rate.',
    `false_negative_count` STRING COMMENT 'Number of actual fraud cases that the rule failed to detect.',
    `false_positive_count` STRING COMMENT 'Number of alerts that were determined to be legitimate activity, not fraud.',
    `false_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of legitimate transactions incorrectly flagged as fraud. Calculated as false positives divided by total legitimate transactions.',
    `measurement_period_end_date` DATE COMMENT 'End date of the performance measurement period for this rule.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the performance measurement period for this rule.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance metrics were calculated and recorded.',
    `ml_model_name` STRING COMMENT 'Name of the machine learning model if this is an ML-based detection rule.',
    `model_type` STRING COMMENT 'Type of detection model or approach used by this rule.. Valid values are `rule_based|machine_learning|hybrid|statistical|heuristic`',
    `performance_status` STRING COMMENT 'Overall assessment of the rules performance based on established benchmarks.. Valid values are `optimal|acceptable|needs_tuning|underperforming|disabled`',
    `precision` DECIMAL(18,2) COMMENT 'Proportion of alerts that were actual fraud cases. Calculated as true positives divided by total alerts generated.',
    `previous_threshold_value` DECIMAL(18,2) COMMENT 'The threshold value before tuning adjustment was applied.',
    `product_applicability` STRING COMMENT 'Banking products or account types to which this rule applies.',
    `sar_escalation_rate` DECIMAL(18,2) COMMENT 'Proportion of alerts that resulted in Suspicious Activity Report filings to FinCEN.',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value (e.g., dollars, transactions, percentage).',
    `total_fraud_loss_detected` DECIMAL(18,2) COMMENT 'Total monetary value of fraud losses identified by this rule during the measurement period.',
    `true_negative_count` STRING COMMENT 'Number of transactions correctly identified as non-fraudulent by the rule.',
    `true_positive_count` STRING COMMENT 'Number of alerts that were confirmed as actual fraud cases.',
    `true_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of actual fraud cases correctly identified by the rule, also known as sensitivity or recall. Calculated as true positives divided by total actual fraud cases.',
    `tuning_action_taken` STRING COMMENT 'Type of tuning adjustment made to the rule based on performance analysis.. Valid values are `threshold_increased|threshold_decreased|logic_modified|rule_disabled|rule_enabled|no_action`',
    `tuning_date` DATE COMMENT 'Date when the rule was tuned or adjusted based on performance metrics.',
    `tuning_rationale` STRING COMMENT 'Business justification and explanation for the tuning adjustment made to the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this performance measurement record was last modified.',
    CONSTRAINT pk_rule_performance PRIMARY KEY(`rule_performance_id`)
) COMMENT 'Performance metrics and tuning record for fraud detection rules and ML models. Captures true positive rate, false positive rate, detection rate, alert volume, and tuning adjustments.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`subject_account_link` (
    `subject_account_link_id` BIGINT COMMENT 'Unique identifier for this fraud subject to investor account association record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud analyst responsible for investigating this specific subject-account relationship.',
    `fraud_subject_id` BIGINT COMMENT 'Foreign key to fraud_subject. Identifies the individual or entity under investigation.',
    `investor_account_id` BIGINT COMMENT 'Foreign key to investor_account. Identifies the account implicated in the fraud investigation.',
    `subject_id` BIGINT COMMENT 'Foreign key linking to the fraud subject entity under investigation',
    `evidence_strength` STRING COMMENT 'Assessment of the strength of evidence linking the fraud subject to this specific investor account. Determines confidence level for law enforcement referral. Explicitly identified in detection phase.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation into this specific fraud subject-account relationship. Controls workflow and reporting. Explicitly identified in detection phase.',
    `last_review_date` DATE COMMENT 'Date when this fraud subject-account link was last reviewed or updated by the investigation team.',
    `link_discovery_date` DATE COMMENT 'Date when the fraud investigation team first identified the connection between this fraud subject and investor account.',
    `link_discovery_method` STRING COMMENT 'The investigative method or data source that revealed the connection between the fraud subject and the account.',
    `notes` STRING COMMENT 'Free-text notes documenting investigation findings, evidence details, and analyst observations specific to this subject-account relationship.',
    `relationship_end_date` DATE COMMENT 'Date when the fraud subjects association with the investor account ended, if applicable. Null for ongoing relationships. Explicitly identified in detection phase.',
    `relationship_start_date` DATE COMMENT 'Date when the fraud subjects association with the investor account began, based on investigation evidence. Explicitly identified in detection phase.',
    `relationship_type` STRING COMMENT 'Classification of the fraud subjects relationship to the investor account. Determines investigation approach and legal implications. Explicitly identified in detection phase.',
    `role_in_fraud` STRING COMMENT 'The fraud subjects specific role in the fraudulent activity involving this account. Determines investigation priority and legal action. Explicitly identified in detection phase.',
    CONSTRAINT pk_subject_account_link PRIMARY KEY(`subject_account_link_id`)
) COMMENT 'This association product represents the investigative link between fraud subjects and investor accounts under investigation. It captures the nature of the relationship (beneficial owner, authorized signer, mule account holder, identity theft victim), the strength of evidence connecting the subject to the account, and the investigation lifecycle status. Each record links one fraud subject to one investor account with attributes that exist only in the context of this fraud investigation relationship.. Existence Justification: In fraud investigation operations, a single fraud subject (individual or entity) can be linked to multiple investor accounts (e.g., organized fraud rings operating across multiple accounts, beneficial ownership structures, mule account networks). Conversely, a single investor account can be associated with multiple fraud subjects (e.g., multiple accomplices using the same account, identity theft with multiple perpetrators, complex fraud schemes with multiple actors). The fraud investigation team actively manages these links as investigative records, tracking evidence strength, roles, and investigation status for each subject-account pair.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`fraud_ring` (
    `fraud_ring_id` BIGINT COMMENT 'Primary key for fraud_ring',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system that created the fraud ring record.',
    `employee_id` BIGINT COMMENT 'Identifier of the fraud investigator or team assigned to manage the fraud ring case.',
    `last_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system that last updated the fraud ring record.',
    `typology_id` BIGINT COMMENT 'Foreign key linking to fraud.typology. Business justification: Each fraud ring operates using a specific fraud typology. N:1 relationship. No bidirectional conflict (typology does not have fraud_ring_id FK back). Normalizing: fraud_typology (STRING) is replaced b',
    `parent_fraud_ring_id` BIGINT COMMENT 'Self-referencing FK on fraud_ring (parent_fraud_ring_id)',
    `affected_channel` STRING COMMENT 'Primary banking channel targeted or exploited by the fraud ring.',
    `closure_date` DATE COMMENT 'Date when the fraud ring case was officially closed or resolved.',
    `confirmed_date` DATE COMMENT 'Date when the fraud ring was confirmed as a coordinated fraud operation through investigation.',
    `confirmed_member_count` STRING COMMENT 'Number of confirmed members identified and verified as part of the fraud ring.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud ring record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts associated with the fraud ring.',
    `detection_method` STRING COMMENT 'Primary method or mechanism through which the fraud ring was initially detected.',
    `estimated_member_count` STRING COMMENT 'Estimated number of individuals or entities participating in the fraud ring.',
    `first_detected_date` DATE COMMENT 'Date when the fraud ring activity was first detected or flagged by fraud detection systems.',
    `geographic_scope` STRING COMMENT 'Geographic reach and operational scope of the fraud ring activities.',
    `last_activity_date` DATE COMMENT 'Date of the most recent fraudulent activity attributed to the fraud ring.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud ring record was last modified or updated.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency notified or involved in the fraud ring investigation.',
    `law_enforcement_case_number` STRING COMMENT 'Case reference number assigned by law enforcement agency for tracking the fraud ring investigation.',
    `law_enforcement_notified_flag` BOOLEAN COMMENT 'Indicates whether law enforcement agencies have been notified about the fraud ring.',
    `linked_case_count` STRING COMMENT 'Number of individual fraud cases linked to and attributed to this fraud ring.',
    `modus_operandi_description` STRING COMMENT 'Detailed description of the fraud rings methods, techniques, and operational patterns.',
    `network_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether network link analysis has been completed to map relationships within the fraud ring.',
    `notes` STRING COMMENT 'Free-text notes and observations from fraud investigators regarding the fraud ring case.',
    `primary_operating_region` STRING COMMENT 'Primary geographic region or jurisdiction where the fraud ring conducts most of its operations.',
    `prosecution_status` STRING COMMENT 'Current status of criminal prosecution proceedings against the fraud ring members.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Total monetary amount recovered from the fraud ring through chargebacks, restitution, or asset seizure, in USD.',
    `ring_identifier_code` STRING COMMENT 'Externally-known unique code assigned to the fraud ring for cross-system reference and reporting.',
    `ring_name` STRING COMMENT 'Human-readable name or label assigned to the fraud ring for identification and tracking purposes.',
    `ring_type` STRING COMMENT 'Classification of the fraud ring based on operational structure and methodology.',
    `risk_score` STRING COMMENT 'Quantitative risk score (0-1000) representing the overall threat level posed by the fraud ring.',
    `sar_filed_flag` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report has been filed with regulatory authorities for this fraud ring.',
    `sar_filing_date` DATE COMMENT 'Date when the Suspicious Activity Report was filed with FinCEN or relevant regulatory authority.',
    `severity_level` STRING COMMENT 'Risk severity classification of the fraud ring based on loss exposure, sophistication, and impact.',
    `sophistication_score` STRING COMMENT 'Numerical score (1-100) representing the operational sophistication and complexity of the fraud ring.',
    `fraud_ring_status` STRING COMMENT 'Current lifecycle status of the fraud ring in the investigation and monitoring workflow.',
    `total_loss_amount` DECIMAL(18,2) COMMENT 'Total monetary loss attributed to the fraud ring across all cases and transactions, in USD.',
    CONSTRAINT pk_fraud_ring PRIMARY KEY(`fraud_ring_id`)
) COMMENT 'Master reference table for fraud_ring. Referenced by fraud_ring_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`fraud`.`merchant` (
    `merchant_id` BIGINT COMMENT 'Primary key for merchant',
    `correspondent_bank_id` BIGINT COMMENT 'Identifier of the acquiring bank or financial institution that sponsors the merchant for payment processing.',
    `payment_processor_id` BIGINT COMMENT 'Identifier of the payment processor or gateway handling the merchants transactions.',
    `parent_merchant_id` BIGINT COMMENT 'Self-referencing FK on merchant (parent_merchant_id)',
    `address_line1` STRING COMMENT 'Primary street address line for the merchants registered business location.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, floor, or building information.',
    `business_registration_number` STRING COMMENT 'Official government-issued business registration or incorporation number.',
    `chargeback_rate` DECIMAL(18,2) COMMENT 'The merchants chargeback rate expressed as a decimal ratio of chargebacks to total transactions, used for fraud monitoring and compliance thresholds.',
    `city` STRING COMMENT 'City where the merchant business is registered or operates.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the merchants country of operation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant record was first created in the system.',
    `dba_name` STRING COMMENT 'The trade name or doing business as name under which the merchant operates, as it appears on customer statements.',
    `email_address` STRING COMMENT 'Primary email address for merchant communications and notifications.',
    `fraud_case_count` STRING COMMENT 'Total number of fraud cases opened against this merchant across all time periods.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Calculated fraud risk score for the merchant based on historical transaction patterns, chargeback rates, and fraud incidents. Scale 0-100.',
    `high_risk_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether the merchant is classified as high-risk based on industry type, fraud history, or regulatory factors.',
    `kyc_verification_date` DATE COMMENT 'Date when the merchants KYC verification was completed or last updated.',
    `kyc_verification_status` STRING COMMENT 'Status of the merchants KYC verification process for anti-money laundering and regulatory compliance.',
    `last_fraud_incident_date` DATE COMMENT 'Date of the most recent confirmed fraud incident associated with this merchant.',
    `mcc` STRING COMMENT 'Four-digit code classifying the merchants type of business or trade, used for transaction categorization and fraud detection rules.',
    `merchant_name` STRING COMMENT 'The legal registered name of the merchant business entity.',
    `merchant_number` STRING COMMENT 'The externally-known unique merchant identification number assigned by the acquiring bank or payment processor.',
    `merchant_type` STRING COMMENT 'Classification of merchant based on transaction acceptance method and channel.',
    `monthly_transaction_count` BIGINT COMMENT 'Average number of transactions processed per month for the merchant.',
    `monthly_transaction_volume` DECIMAL(18,2) COMMENT 'Average monthly transaction volume in base currency for the merchant, used for risk assessment and monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the merchant account.',
    `onboarding_date` DATE COMMENT 'The date when the merchant was onboarded and approved to accept payments.',
    `pci_compliance_status` STRING COMMENT 'Current PCI DSS compliance status of the merchant.',
    `pci_validation_date` DATE COMMENT 'Date of the most recent PCI DSS compliance validation or assessment.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the merchant business.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the merchants business address.',
    `risk_tier` STRING COMMENT 'Risk classification tier assigned to the merchant based on fraud history, transaction patterns, and business type.',
    `sar_filed_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether a Suspicious Activity Report has been filed for this merchant.',
    `settlement_account_number` STRING COMMENT 'Bank account number where merchant transaction settlements are deposited.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO currency code for the merchants settlement currency.',
    `state_province` STRING COMMENT 'State or province code for the merchants business location.',
    `merchant_status` STRING COMMENT 'Current operational status of the merchant in the payment processing system.',
    `tax_identifier` STRING COMMENT 'The merchants tax identification number or employer identification number for regulatory and tax reporting purposes.',
    `termination_date` DATE COMMENT 'The date when the merchant relationship was terminated or the merchant account was closed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant record was last modified or updated.',
    `watchlist_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether the merchant is on a fraud watchlist or monitoring list requiring enhanced scrutiny.',
    `website_url` STRING COMMENT 'The merchants primary website or ecommerce URL.',
    CONSTRAINT pk_merchant PRIMARY KEY(`merchant_id`)
) COMMENT 'Master reference table for merchant. Referenced by merchant_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_fraud_ring_id` FOREIGN KEY (`fraud_ring_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_ring`(`fraud_ring_id`);
ALTER TABLE `banking_ecm`.`fraud`.`case` ADD CONSTRAINT `fk_fraud_case_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `banking_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_previous_investigation_id` FOREIGN KEY (`previous_investigation_id`) REFERENCES `banking_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `banking_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ADD CONSTRAINT `fk_fraud_fraud_incident_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_merchant_id` FOREIGN KEY (`merchant_id`) REFERENCES `banking_ecm`.`fraud`.`merchant`(`merchant_id`);
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ADD CONSTRAINT `fk_fraud_chargeback_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_amended_sar_sar_filing_id` FOREIGN KEY (`amended_sar_sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ADD CONSTRAINT `fk_fraud_sar_filing_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ADD CONSTRAINT `fk_fraud_loss_recovery_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ADD CONSTRAINT `fk_fraud_detection_rule_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `banking_ecm`.`fraud`.`chargeback`(`chargeback_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`claim` ADD CONSTRAINT `fk_fraud_claim_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_fraud_ring_id` FOREIGN KEY (`fraud_ring_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_ring`(`fraud_ring_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ADD CONSTRAINT `fk_fraud_network_link_target_subject_id` FOREIGN KEY (`target_subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_fraud_ring_id` FOREIGN KEY (`fraud_ring_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_ring`(`fraud_ring_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject` ADD CONSTRAINT `fk_fraud_subject_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ADD CONSTRAINT `fk_fraud_law_enforcement_referral_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ADD CONSTRAINT `fk_fraud_law_enforcement_referral_sar_filing_id` FOREIGN KEY (`sar_filing_id`) REFERENCES `banking_ecm`.`fraud`.`sar_filing`(`sar_filing_id`);
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ADD CONSTRAINT `fk_fraud_law_enforcement_referral_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ADD CONSTRAINT `fk_fraud_fraud_watchlist_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`typology` ADD CONSTRAINT `fk_fraud_typology_parent_typology_id` FOREIGN KEY (`parent_typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_case_id` FOREIGN KEY (`case_id`) REFERENCES `banking_ecm`.`fraud`.`case`(`case_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_fraud_incident_id` FOREIGN KEY (`fraud_incident_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_incident`(`fraud_incident_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_reversal_fraud_loss_id` FOREIGN KEY (`reversal_fraud_loss_id`) REFERENCES `banking_ecm`.`fraud`.`loss`(`loss_id`);
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ADD CONSTRAINT `fk_fraud_rule_performance_detection_rule_id` FOREIGN KEY (`detection_rule_id`) REFERENCES `banking_ecm`.`fraud`.`detection_rule`(`detection_rule_id`);
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ADD CONSTRAINT `fk_fraud_rule_performance_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ADD CONSTRAINT `fk_fraud_rule_performance_previous_rule_performance_id` FOREIGN KEY (`previous_rule_performance_id`) REFERENCES `banking_ecm`.`fraud`.`rule_performance`(`rule_performance_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ADD CONSTRAINT `fk_fraud_subject_account_link_fraud_subject_id` FOREIGN KEY (`fraud_subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ADD CONSTRAINT `fk_fraud_subject_account_link_subject_id` FOREIGN KEY (`subject_id`) REFERENCES `banking_ecm`.`fraud`.`subject`(`subject_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ADD CONSTRAINT `fk_fraud_fraud_ring_typology_id` FOREIGN KEY (`typology_id`) REFERENCES `banking_ecm`.`fraud`.`typology`(`typology_id`);
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ADD CONSTRAINT `fk_fraud_fraud_ring_parent_fraud_ring_id` FOREIGN KEY (`parent_fraud_ring_id`) REFERENCES `banking_ecm`.`fraud`.`fraud_ring`(`fraud_ring_id`);
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ADD CONSTRAINT `fk_fraud_merchant_parent_merchant_id` FOREIGN KEY (`parent_merchant_id`) REFERENCES `banking_ecm`.`fraud`.`merchant`(`merchant_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`fraud` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`fraud` SET TAGS ('dbx_domain' = 'fraud');
ALTER TABLE `banking_ecm`.`fraud`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`case` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Of Occurrence Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Relationship Manager Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `contact_center_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Intake Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `journey_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Journey Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Source Alert ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_ring_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Assigned Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^FC-[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'new|assigned|under_investigation|pending_review|closed|escalated');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'card_fraud|wire_fraud|ach_fraud|check_fraud|identity_theft|account_takeover');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `chargeback_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `confirmed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `customer_reimbursed_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Reimbursed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_business_glossary_term' = 'Disposition Outcome');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `disposition_outcome` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|customer_error|insufficient_evidence|referred_law_enforcement');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_detection_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|customer_report|manual_review|third_party_alert');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `fraud_ring_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `insurance_claim_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `reimbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Amount');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `reimbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Date');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `related_case_count` SET TAGS ('dbx_business_glossary_term' = 'Related Case Count');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `sla_target_close_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Close Date');
ALTER TABLE `banking_ecm`.`fraud`.`case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` SET TAGS ('dbx_subdomain' = 'detection_rules');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `journey_id` SET TAGS ('dbx_business_glossary_term' = 'Journey Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Number');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `alert_number` SET TAGS ('dbx_value_regex' = '^FA-[0-9]{10}$');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Status');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `alert_status` SET TAGS ('dbx_value_regex' = 'new|under_review|escalated|closed|false_positive|confirmed_fraud');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `assigned_analyst_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Name');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Number Last Four Digits');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `customer_contact_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `customer_contacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Contacted Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `customer_response` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Classification');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `customer_response` SET TAGS ('dbx_value_regex' = 'confirmed_legitimate|confirmed_fraud|no_response|disputed');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|behavioral_analytics|manual_referral|customer_report|third_party_alert');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Alert Disposition Code');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|suspicious_no_action|escalated_to_case|customer_verified|pending_information');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Alert Disposition Reason');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `escalated_to_case_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `false_positive_reason` SET TAGS ('dbx_business_glossary_term' = 'False Positive Reason');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `review_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Severity Level');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Employee ID');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `previous_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Investigation ID');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `chargeback_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `customer_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_items_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Items Count');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Evidence Summary');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `findings_narrative` SET TAGS ('dbx_business_glossary_term' = 'Findings Narrative');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `findings_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_loss_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_loss_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Interview Conducted Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_notes` SET TAGS ('dbx_business_glossary_term' = 'Interview Notes');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `interview_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|escalated|completed|cancelled');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Investigation Methodology');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'transaction_analysis|device_forensics|customer_interview|surveillance_review|third_party_data|multi_method');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `multi_phase_investigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Phase Investigation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Investigation Phase');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'initial_review|deep_investigation|legal_referral|sar_escalation|closed|suspended');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `recommended_disposition` SET TAGS ('dbx_business_glossary_term' = 'Recommended Disposition');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `recommended_disposition` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|no_fraud|inconclusive|referred_to_compliance|referred_to_legal|customer_error');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sar_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Escalation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `sla_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Investigation Source System');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`investigation` ALTER COLUMN `team` SET TAGS ('dbx_business_glossary_term' = 'Investigation Team');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Incident Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Number Last Four Digits');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `card_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `customer_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Reported Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'system_rule|ml_model|customer_report|manual_review|third_party_alert');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|customer_error|merchant_error|unresolved|pending');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|confirmed|dismissed|closed|escalated');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `loss_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `transaction_location` SET TAGS ('dbx_business_glossary_term' = 'Transaction Location');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank Identification Number (BIN)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `arbitration_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Filed Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_network` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Network');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|charge');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|accepted|rejected|reversed|withdrawn');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `fraud_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Bank Identification Number (BIN)');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Card Number');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `masked_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `merchant_name` SET TAGS ('dbx_business_glossary_term' = 'Merchant Name');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `network_case_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `original_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Description');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Received Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `representment_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Representment Filed Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'cardholder_favor|merchant_favor|partial_reversal|withdrawn|expired');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `sar_filed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Lifecycle Stage');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'first_chargeback|representment|pre_arbitration|arbitration|closed');
ALTER TABLE `banking_ecm`.`fraud`.`chargeback` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `alco_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Meeting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `amended_sar_sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Suspicious Activity Report (SAR) ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `regulatory_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Party ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `tertiary_sar_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `tertiary_sar_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `tertiary_sar_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `activity_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Filing Institution Contact Name');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Filing Institution Contact Phone Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Filing Institution Name');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_tin` SET TAGS ('dbx_business_glossary_term' = 'Filing Institution Taxpayer Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_institution_tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `fincen_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Crimes Enforcement Network (FinCEN) Acknowledgment Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `fincen_bsa_reference` SET TAGS ('dbx_business_glossary_term' = 'Financial Crimes Enforcement Network (FinCEN) Bank Secrecy Act (BSA) Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `law_enforcement_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency Name');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `law_enforcement_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Contact Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `prior_sar_reference` SET TAGS ('dbx_business_glossary_term' = 'Prior Suspicious Activity Report (SAR) Reference');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_type` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Type');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `sar_type` SET TAGS ('dbx_value_regex' = 'fraud_related|aml_related|combined');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_address` SET TAGS ('dbx_business_glossary_term' = 'Subject Address');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_email` SET TAGS ('dbx_business_glossary_term' = 'Subject Email Address');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_name` SET TAGS ('dbx_business_glossary_term' = 'Subject Name');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_phone` SET TAGS ('dbx_business_glossary_term' = 'Subject Phone Number');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_tin` SET TAGS ('dbx_business_glossary_term' = 'Subject Taxpayer Identification Number (TIN)');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `subject_tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `suspicious_activity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity End Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `suspicious_activity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `suspicious_activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Type Code');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `total_suspicious_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Suspicious Amount');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `total_suspicious_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `total_suspicious_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `banking_ecm`.`fraud`.`sar_filing` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_recovery_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Recovery Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Basel Event Type Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_value_regex' = '^[1-7].[1-9]$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `business_line` SET TAGS ('dbx_value_regex' = 'retail_banking|corporate_banking|payment_services|trading_sales|asset_management|commercial_banking');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `ccar_loss_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Loss Event Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `chargeback_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `chargeback_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,25}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'card_fraud|wire_fraud|ach_fraud|check_fraud|account_takeover|identity_theft');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Discovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_event_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Event Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_event_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_status` SET TAGS ('dbx_business_glossary_term' = 'Loss Status');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `loss_status` SET TAGS ('dbx_value_regex' = 'open|under_review|recovery_in_progress|closed_recovered|closed_written_off');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_notes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Notes');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|partial_recovery|full_recovery|abandoned|write_off');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `write_off_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Approval Authority');
ALTER TABLE `banking_ecm`.`fraud`.`loss_recovery` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` SET TAGS ('dbx_subdomain' = 'detection_rules');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `continuous_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `alert_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority Score');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `alert_volume` SET TAGS ('dbx_business_glossary_term' = 'Alert Volume');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `case_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Case Conversion Rate');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `customer_segment_applicability` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Applicability');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `detection_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Detection Effectiveness Score');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `false_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'False Positive Rate (FPR)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `last_tuning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tuning Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `ml_model_name` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Name');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `ml_model_version` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Version');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|hybrid|statistical');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `product_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Applicability');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'velocity_check|amount_threshold|geographic_anomaly|device_fingerprint|behavioral_pattern|account_takeover');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Rule Documentation Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_logic` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_owner` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_severity` SET TAGS ('dbx_business_glossary_term' = 'Rule Severity Level');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|testing|retired|suspended');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `sar_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Escalation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'currency|count|percentage|score|standard_deviation');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `time_window_unit` SET TAGS ('dbx_business_glossary_term' = 'Time Window Unit');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `time_window_unit` SET TAGS ('dbx_value_regex' = 'minute|hour|day|week|month');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `time_window_value` SET TAGS ('dbx_business_glossary_term' = 'Time Window Value');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `true_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'True Positive Rate (TPR)');
ALTER TABLE `banking_ecm`.`fraud`.`detection_rule` ALTER COLUMN `tuning_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Tuning Frequency in Days');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Evidence Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `workpaper_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Workpaper Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collecting Analyst Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `admissibility_classification` SET TAGS ('dbx_business_glossary_term' = 'Admissibility Classification');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `admissibility_classification` SET TAGS ('dbx_value_regex' = 'admissible|inadmissible|pending_review|conditional');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Archived Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'collected|secured|transferred|archived|destroyed');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collection Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Evidence Confidentiality Level');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `contains_pii_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Personally Identifiable Information (PII) Flag');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destroyed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Destroyed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destruction_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorized By Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Evidence Destruction Method');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `destruction_method` SET TAGS ('dbx_value_regex' = 'secure_deletion|shredding|degaussing|incineration');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'transaction_log|device_fingerprint|ip_geolocation|call_recording|surveillance_footage|document_image');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Format');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Name');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'SHA-256|SHA-512|MD5');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `hash_value` SET TAGS ('dbx_business_glossary_term' = 'Evidence Hash Value');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `internal_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `law_enforcement_shared_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Shared Flag');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `legal_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Evidence Notes');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `regulatory_exam_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Evidence Relevance Score');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Days');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `secure_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Secure Storage Reference');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `secure_storage_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source System');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'core_banking|card_processor|digital_banking|telephony|physical_security|payment_hub');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_method` SET TAGS ('dbx_business_glossary_term' = 'Evidence Transfer Method');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_method` SET TAGS ('dbx_value_regex' = 'secure_email|encrypted_file_transfer|physical_media|secure_portal|in_person');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_recipient` SET TAGS ('dbx_business_glossary_term' = 'Evidence Transfer Recipient');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evidence Transfer Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`claim` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Claim ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Rm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_provisional_credit_account_deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Claimed Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `contact_center_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Contact Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `chargeback_initiated` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Initiated');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^CLM[0-9]{10}$');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'unauthorized_transaction|identity_theft|account_takeover|card_fraud|check_fraud|wire_fraud');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `customer_attestation_received` SET TAGS ('dbx_business_glossary_term' = 'Customer Attestation Received');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `final_credit_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Final Credit Confirmation Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `final_credit_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Final Credit Confirmed');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `law_enforcement_referral` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Issued Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Reversal Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `provisional_credit_reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Provisional Credit Reversal Reason');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Receipt Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Receipt Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_value_regex' = 'reg_e_10_day|reg_z_5_day|reg_e_45_day|voluntary|none');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_code` SET TAGS ('dbx_value_regex' = 'approved_customer_favor|denied_authorized_transaction|denied_insufficient_evidence|withdrawn_by_customer|closed_duplicate');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `sar_bsa_identifier` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Bank Secrecy Act (BSA) Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `sar_bsa_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `sar_filed` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `network_link_id` SET TAGS ('dbx_business_glossary_term' = 'Network Link Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Analyst Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `fraud_ring_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fraud Case Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Source Subject Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `target_subject_id` SET TAGS ('dbx_business_glossary_term' = 'Target Subject Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `analyst_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `bidirectional_flag` SET TAGS ('dbx_business_glossary_term' = 'Bidirectional Relationship Flag');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'automated_graph_analysis|manual_investigation|tip_referral|cross_case_review|pattern_matching|external_intelligence');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `first_observed_date` SET TAGS ('dbx_business_glossary_term' = 'First Observed Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `graph_visualization_metadata` SET TAGS ('dbx_business_glossary_term' = 'Graph Visualization Metadata');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `last_observed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Observed Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Link Evidence Description');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_evidence_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Link Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_status` SET TAGS ('dbx_business_glossary_term' = 'Link Status');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|confirmed|disputed|archived');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Link Strength Score');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_type` SET TAGS ('dbx_business_glossary_term' = 'Network Link Type');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `link_type` SET TAGS ('dbx_value_regex' = 'shared_device_fingerprint|shared_ip_address|shared_physical_address|shared_phone_number|common_beneficiary_account|mule_account_network');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `network_depth_level` SET TAGS ('dbx_business_glossary_term' = 'Network Depth Level');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `observation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Observation Frequency');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `related_case_count` SET TAGS ('dbx_business_glossary_term' = 'Related Case Count');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Network Link Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `sar_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Included Flag');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `shared_attribute_value` SET TAGS ('dbx_business_glossary_term' = 'Shared Attribute Value');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `shared_attribute_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`network_link` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`subject` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `fraud_ring_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Address Line 1');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Address Line 2');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_account_numbers` SET TAGS ('dbx_business_glossary_term' = 'Associated Account Numbers');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_account_numbers` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_account_numbers` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_device_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Device Identifiers (IDs)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_device_ids` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_device_ids` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_ip_addresses` SET TAGS ('dbx_business_glossary_term' = 'Associated Internet Protocol (IP) Addresses');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_ip_addresses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `associated_ip_addresses` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject City');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Date of Birth (DOB)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `drivers_license_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Drivers License Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `drivers_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `drivers_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Email Address');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_identified_date` SET TAGS ('dbx_business_glossary_term' = 'First Identified Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject First Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `fraud_ring_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Full Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `known_aliases` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Known Aliases');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `known_aliases` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `known_aliases` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Last Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Middle Name');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject National Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Passport Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Phone Number');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Postal Code');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `prior_fraud_case_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Fraud Case Count');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Risk Tier');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject State or Province');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Status');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_status` SET TAGS ('dbx_value_regex' = 'active|inactive|watchlist|law_enforcement_referred|cleared|deceased');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Type');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `subject_type` SET TAGS ('dbx_value_regex' = 'internal_employee|external_third_party|customer|organized_fraud_ring_member|unknown|mule_account_holder');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `total_confirmed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Confirmed Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `total_estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `watchlist_status` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Status');
ALTER TABLE `banking_ecm`.`fraud`.`subject` ALTER COLUMN `watchlist_status` SET TAGS ('dbx_value_regex' = 'not_on_watchlist|internal_watchlist|law_enforcement_watchlist|industry_watchlist|sanctions_list');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `law_enforcement_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral ID');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Liaison Employee ID');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_case_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Name');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Phone');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Liaison Email');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Liaison Name');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Liaison Phone');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `bank_liaison_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `confirmed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `evidence_package_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Package Reference');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `evidence_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Method');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `evidence_submission_method` SET TAGS ('dbx_value_regex' = 'secure_portal|encrypted_email|physical_delivery|secure_file_transfer|in_person');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `investigation_status_update` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status Update');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `legal_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Obligation Flag');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `prosecution_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Initiated Flag');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `receiving_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Agency Name');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `receiving_agency_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Agency Type');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `receiving_agency_type` SET TAGS ('dbx_value_regex' = 'federal|state|local|international');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_priority` SET TAGS ('dbx_business_glossary_term' = 'Referral Priority');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_reason` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|under_investigation|closed|withdrawn');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'criminal_complaint|subpoena_response|voluntary_disclosure|information_sharing|grand_jury_subpoena|search_warrant_response');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `restitution_amount` SET TAGS ('dbx_business_glossary_term' = 'Restitution Amount');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `restitution_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Restitution Received Amount');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `subpoena_number` SET TAGS ('dbx_business_glossary_term' = 'Subpoena Number');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `subpoena_received_date` SET TAGS ('dbx_business_glossary_term' = 'Subpoena Received Date');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `subpoena_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Subpoena Received Flag');
ALTER TABLE `banking_ecm`.`fraud`.`law_enforcement_referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` SET TAGS ('dbx_subdomain' = 'detection_rules');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `associated_account_count` SET TAGS ('dbx_business_glossary_term' = 'Associated Account Count');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `associated_party_count` SET TAGS ('dbx_business_glossary_term' = 'Associated Party Count');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `blacklist_date` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Date');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `blacklist_status` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Status');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `blacklist_status` SET TAGS ('dbx_value_regex' = 'not_blacklisted|blacklisted|watchlist|whitelisted');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `browser_name` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `browser_version` SET TAGS ('dbx_business_glossary_term' = 'Browser Version');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `cookie_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cookie Enabled Flag');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_reputation_score` SET TAGS ('dbx_business_glossary_term' = 'Device Reputation Score');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|tablet|atm_terminal|pos_terminal|kiosk');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `emulator_indicator` SET TAGS ('dbx_business_glossary_term' = 'Emulator Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Hash');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `first_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Seen Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fraud_case_count` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Count');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fraud_typology` SET TAGS ('dbx_business_glossary_term' = 'Fraud Typology');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `javascript_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'JavaScript Enabled Flag');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `last_fraud_alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Fraud Alert Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System (OS)');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `proxy_vpn_indicator` SET TAGS ('dbx_business_glossary_term' = 'Proxy or Virtual Private Network (VPN) Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `risk_score_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `rooted_jailbroken_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rooted or Jailbroken Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `screen_resolution` SET TAGS ('dbx_business_glossary_term' = 'Screen Resolution');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `timezone_offset` SET TAGS ('dbx_business_glossary_term' = 'Timezone Offset');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `tor_network_indicator` SET TAGS ('dbx_business_glossary_term' = 'The Onion Router (TOR) Network Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `user_agent_string` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `velocity_24h_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Velocity 24-Hour Transaction Count');
ALTER TABLE `banking_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `velocity_7d_login_count` SET TAGS ('dbx_business_glossary_term' = 'Velocity 7-Day Login Count');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` SET TAGS ('dbx_subdomain' = 'detection_rules');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `fraud_watchlist_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Watchlist ID');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Fraud Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Adding Analyst ID');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `tertiary_fraud_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `tertiary_fraud_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `tertiary_fraud_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `action_tier` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Action Tier');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `action_tier` SET TAGS ('dbx_value_regex' = 'monitor_only|enhanced_authentication|transaction_restrict|hard_block');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Number');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `entry_number` SET TAGS ('dbx_value_regex' = '^WL-[0-9]{10}$');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Type');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'customer|account_number|device_fingerprint|merchant_id|ip_address_range|bin_range');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Expiry Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `industry_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Industry Sharing Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `last_match_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Match Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `law_enforcement_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notified Flag');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `match_count` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Match Count');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Notes');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Reason Code');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|suspected_fraud|industry_intelligence|synthetic_identity|account_takeover|chargeback_abuse');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Reason Description');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Removal Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Removal Reason');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Review Date');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Review Status');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'active|under_review|expired|removed');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `sar_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `severity_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Severity Score');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `sharing_network` SET TAGS ('dbx_business_glossary_term' = 'Fraud Sharing Network');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Source System');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'internal_investigation|industry_sharing|law_enforcement|third_party_intelligence');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `watchlisted_value` SET TAGS ('dbx_business_glossary_term' = 'Watchlisted Value');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_watchlist` ALTER COLUMN `watchlisted_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`typology` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`fraud`.`typology` SET TAGS ('dbx_subdomain' = 'detection_rules');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Typology Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Owner Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `parent_typology_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `attack_vector` SET TAGS ('dbx_business_glossary_term' = 'Attack Vector');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `average_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Basel Event Type Code');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_value_regex' = '^[1-7]$');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `chargeback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Eligible Flag');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `cross_border_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `customer_reimbursement_policy` SET TAGS ('dbx_business_glossary_term' = 'Customer Reimbursement Policy');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `customer_reimbursement_policy` SET TAGS ('dbx_value_regex' = 'full_reimbursement|conditional_reimbursement|no_reimbursement|case_by_case');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'retail|commercial|wealth|institutional|all');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `detection_difficulty_score` SET TAGS ('dbx_business_glossary_term' = 'Detection Difficulty Score');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `detection_method_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `detection_method_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Detection Method');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `incident_volume_12m` SET TAGS ('dbx_business_glossary_term' = 'Incident Volume 12 Month (12M)');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `industry_prevalence_rank` SET TAGS ('dbx_business_glossary_term' = 'Industry Prevalence Rank');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `law_enforcement_referral_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Recommended Flag');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `maximum_observed_loss` SET TAGS ('dbx_business_glossary_term' = 'Maximum Observed Loss');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `median_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Median Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `organized_crime_indicator` SET TAGS ('dbx_business_glossary_term' = 'Organized Crime Indicator');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `prevention_control_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Prevention Control');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `prevention_control_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Prevention Control');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `recovery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate Percentage');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `risk_severity_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Tier');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `risk_severity_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `sar_filing_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Threshold Amount');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `sophistication_level` SET TAGS ('dbx_business_glossary_term' = 'Sophistication Level');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `sophistication_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Fraud Typology Subcategory');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `target_channel` SET TAGS ('dbx_business_glossary_term' = 'Target Channel');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `target_product_line` SET TAGS ('dbx_business_glossary_term' = 'Target Product Line');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `total_loss_amount_12m` SET TAGS ('dbx_business_glossary_term' = 'Total Loss Amount 12 Month (12M)');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|emerging|declining');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Typology Category');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Typology Code');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_description` SET TAGS ('dbx_business_glossary_term' = 'Typology Description');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Typology Name');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_status` SET TAGS ('dbx_business_glossary_term' = 'Typology Status');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `typology_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|emerging|under_review');
ALTER TABLE `banking_ecm`.`fraud`.`typology` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`loss` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss ID');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `fraud_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Incident Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `reversal_fraud_loss_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `basel_event_type_code` SET TAGS ('dbx_business_glossary_term' = 'Basel Event Type Code');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `ccar_loss_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) Loss Event Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `chargeback_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reference Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Discovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Event Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `gl_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Reference');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `insurance_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Number');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'internal_fraud|external_fraud|card_fraud|wire_fraud|ach_fraud|check_fraud');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_status` SET TAGS ('dbx_business_glossary_term' = 'Loss Status');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `loss_status` SET TAGS ('dbx_value_regex' = 'confirmed|under_review|partially_recovered|fully_recovered|written_off');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'insurance|chargeback|legal_action|customer_reimbursement|collateral_liquidation|none');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_notes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Notes');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `write_off_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Approval Authority');
ALTER TABLE `banking_ecm`.`fraud`.`loss` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` SET TAGS ('dbx_subdomain' = 'detection_rules');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `rule_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Performance ID');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule ID');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Tuning Analyst ID');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `previous_rule_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `alert_review_time_avg_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Alert Review Time (Minutes)');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `alert_volume` SET TAGS ('dbx_business_glossary_term' = 'Alert Volume');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `average_fraud_loss_per_alert` SET TAGS ('dbx_business_glossary_term' = 'Average Fraud Loss Per Alert');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `case_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Case Conversion Rate');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Channel Applicability');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `current_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Current Threshold Value');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `detection_rate` SET TAGS ('dbx_business_glossary_term' = 'Detection Rate');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `false_negative_count` SET TAGS ('dbx_business_glossary_term' = 'False Negative Count');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `false_positive_count` SET TAGS ('dbx_business_glossary_term' = 'False Positive Count');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `false_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'False Positive Rate (FPR)');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `ml_model_name` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning (ML) Model Name');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'rule_based|machine_learning|hybrid|statistical|heuristic');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Status');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'optimal|acceptable|needs_tuning|underperforming|disabled');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `precision` SET TAGS ('dbx_business_glossary_term' = 'Precision');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `previous_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Threshold Value');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `product_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Applicability');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `sar_escalation_rate` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Escalation Rate');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `total_fraud_loss_detected` SET TAGS ('dbx_business_glossary_term' = 'Total Fraud Loss Detected');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `true_negative_count` SET TAGS ('dbx_business_glossary_term' = 'True Negative Count');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `true_positive_count` SET TAGS ('dbx_business_glossary_term' = 'True Positive Count');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `true_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'True Positive Rate (TPR)');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `tuning_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Tuning Action Taken');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `tuning_action_taken` SET TAGS ('dbx_value_regex' = 'threshold_increased|threshold_decreased|logic_modified|rule_disabled|rule_enabled|no_action');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `tuning_date` SET TAGS ('dbx_business_glossary_term' = 'Tuning Date');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `tuning_rationale` SET TAGS ('dbx_business_glossary_term' = 'Tuning Rationale');
ALTER TABLE `banking_ecm`.`fraud`.`rule_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` SET TAGS ('dbx_association_edges' = 'fraud.fraud_subject,asset.investor_account');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `subject_account_link_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Account Link Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigating Analyst Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `fraud_subject_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `subject_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Subject Account Link - Fraud Subject Id');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `evidence_strength` SET TAGS ('dbx_business_glossary_term' = 'Evidence Strength Rating');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `link_discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Link Discovery Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `link_discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Link Discovery Method');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `notes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Relationship Type');
ALTER TABLE `banking_ecm`.`fraud`.`subject_account_link` ALTER COLUMN `role_in_fraud` SET TAGS ('dbx_business_glossary_term' = 'Role in Fraud Scheme');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `fraud_ring_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Ring Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `typology_id` SET TAGS ('dbx_business_glossary_term' = 'Typology Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `parent_fraud_ring_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `modus_operandi_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`fraud_ring` ALTER COLUMN `total_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` SET TAGS ('dbx_subdomain' = 'entity_registry');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `parent_merchant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`fraud`.`merchant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
