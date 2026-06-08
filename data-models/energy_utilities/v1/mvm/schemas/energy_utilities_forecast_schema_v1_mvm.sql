-- Schema for Domain: forecast | Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`forecast` COMMENT 'Load forecasting, generation forecasting, renewable intermittency prediction, peak demand planning, weather correlation analysis, and long-term capacity planning. Manages short-term operational forecasts, seasonal planning, and IRP scenario modeling for resource adequacy and grid reliability. Supports operational decision-making for dispatch, procurement, and infrastructure investment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`load` (
    `load_id` BIGINT COMMENT 'Primary key for load',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Load forecasts are always scoped to a control area for balancing authority operations, AGC dispatch, ACE calculation, and NERC CPS1/CPS2 compliance reporting. Control area is the fundamental operation',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.run. Business justification: Load is the master forecast record; load_forecast_interval contains the interval-level detail. Linking load to run establishes the execution context for the forecast master. The run table captures exe',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Load forecasts are spatially scoped to forecast zones. The zone table defines geographic boundaries, substation counts, and peak load characteristics. Adding forecast_zone_id FK allows retrieval of zo',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: Load forecasts are produced by registered forecasting models. The model table is the authoritative source for model configuration, hyperparameters, and validation metrics. Adding forecast_model_id FK ',
    `load_model_id` BIGINT COMMENT 'FK to forecast.model.model_id — Every load forecast run is produced by a registered forecast model. This FK enables model governance — tracing which model produced which forecast for accuracy comparison and champion/challenger evalu',
    `load_zone_id` BIGINT COMMENT 'FK to forecast.zone.zone_id — Load forecasts are scoped to a geographic forecast zone (system, zone, feeder). This FK enables zone-level aggregation and accuracy tracking.',
    `primary_baseline_forecast_load_id` BIGINT COMMENT 'Reference to the baseline or reference forecast run used for comparison or adjustment. Used in scenario analysis and variance tracking.',
    `weather_input_id` BIGINT COMMENT 'FK to forecast.weather_input.weather_input_id — Load forecasts use weather forecast inputs as the primary exogenous variable. This FK enables traceability from forecast to weather scenario used.',
    `approved_by` STRING COMMENT 'The name or identifier of the person or role who approved this forecast for operational use. Used for governance and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast was formally approved for operational use in dispatch planning, procurement, or IRP.',
    `confidence_level` STRING COMMENT 'The probabilistic confidence level of the forecast: P10 (10th percentile, low case), P50 (median, base case), P90 (90th percentile, high case), P95, or deterministic (single-point forecast without probability distribution).. Valid values are `p10|p50|p90|p95|deterministic`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was first created in the system. Audit trail for data lineage and governance.',
    `data_source` STRING COMMENT 'The primary source system or module from which this forecast was generated (e.g., EMS Load Forecasting Module, ADMS Forecasting Engine, OSIsoft PI Analytics, third-party forecasting service).',
    `day_type` STRING COMMENT 'Classification of the forecast period by day type: weekday, weekend, holiday, or special event. Used to apply appropriate load shape patterns.. Valid values are `weekday|weekend|holiday|special_event`',
    `demand_response_adjustment_mw` DECIMAL(18,2) COMMENT 'The forecasted reduction in load (MW) due to active Demand Response (DR) programs during the forecast period. Represents expected customer participation in load curtailment programs.',
    `der_penetration_percent` DECIMAL(18,2) COMMENT 'The assumed percentage of load served by behind-the-meter Distributed Energy Resources (DER) such as rooftop solar, battery storage, and microgrids. Impacts net load forecast.',
    `economic_scenario` STRING COMMENT 'The economic growth scenario applied in long-term forecasts: base case, high growth, low growth, recession, or recovery. Used primarily in IRP and multi-year forecasts.. Valid values are `base|high_growth|low_growth|recession|recovery`',
    `electric_vehicle_load_mw` DECIMAL(18,2) COMMENT 'The forecasted incremental load (MW) attributable to electric vehicle charging within the forecast period. Represents EV adoption impact on load growth.',
    `energy_efficiency_adjustment_mwh` DECIMAL(18,2) COMMENT 'The forecasted reduction in energy consumption (MWh) due to energy efficiency programs and measures implemented since the baseline forecast. Reflects cumulative EE program impacts.',
    `forecast_accuracy_mape` DECIMAL(18,2) COMMENT 'The Mean Absolute Percentage Error (MAPE) of this forecast compared to actual metered load, calculated post-facto. Measures forecast accuracy for model performance tracking.',
    `forecast_bias_percent` DECIMAL(18,2) COMMENT 'The systematic bias (over-forecast or under-forecast) of this forecast as a percentage, calculated post-facto by comparing to actual load. Positive values indicate over-forecast; negative indicate under-forecast.',
    `forecast_end_timestamp` TIMESTAMP COMMENT 'The ending timestamp of the forecast target period. Defines the last interval covered by this forecast run.',
    `forecast_start_timestamp` TIMESTAMP COMMENT 'The beginning timestamp of the forecast target period for which load demand is being predicted. Represents the first interval of the forecast horizon.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast run indicating its approval state and operational readiness for use in dispatch and planning decisions.. Valid values are `draft|pending_review|approved|published|superseded|archived`',
    `forecast_type` STRING COMMENT 'Classification of the forecast by planning horizon: short-term (intra-day to 7 days), day-ahead (next 24-48 hours), week-ahead (7-14 days), seasonal (monthly/quarterly), long-term (annual/multi-year), or IRP scenario (Integrated Resource Plan modeling).. Valid values are `short_term|day_ahead|week_ahead|seasonal|long_term|irp_scenario`',
    `geographic_scope` STRING COMMENT 'The geographic or network level at which the load forecast is aggregated: system-wide (entire utility), zone (load zone or pricing zone), substation, feeder (distribution circuit), service territory, or balancing authority area.. Valid values are `system_wide|zone|substation|feeder|service_territory|balancing_authority`',
    `interval_resolution_minutes` STRING COMMENT 'The time resolution of forecast intervals in minutes (e.g., 5, 15, 60). Defines the granularity at which forecasted MW demand values are provided.',
    `model_version` STRING COMMENT 'Version identifier of the forecasting model or algorithm used to generate this forecast run. Enables traceability and model performance comparison.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was last modified. Audit trail for data lineage and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this forecast run, including special assumptions, model adjustments, or operational context that influenced the forecast.',
    `peak_demand_mw` DECIMAL(18,2) COMMENT 'The forecasted peak load demand in megawatts (MW) for the target period. Represents the maximum expected load across all intervals in this forecast run.',
    `peak_demand_timestamp` TIMESTAMP COMMENT 'The timestamp at which the peak demand is forecasted to occur within the target period.',
    `published_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast was published and made available to downstream systems (EMS, ADMS, trading systems) for operational decision-making.',
    `season` STRING COMMENT 'The meteorological or operational season applicable to the forecast period: winter, spring, summer, or fall. Influences load shape and magnitude.. Valid values are `winter|spring|summer|fall`',
    `temperature_sensitivity_mw_per_degree` DECIMAL(18,2) COMMENT 'The estimated change in load demand (MW) per degree change in temperature. Represents the temperature-load correlation coefficient used in weather-adjusted forecasting.',
    `total_energy_mwh` DECIMAL(18,2) COMMENT 'The total forecasted energy consumption in megawatt-hours (MWh) across the entire forecast period. Sum of all interval forecasts.',
    `weather_scenario` STRING COMMENT 'The weather condition scenario applied in the forecast: actual (observed weather), normal (historical average), extreme heat, extreme cold, high wind, low wind, or probabilistic percentiles (P10/P50/P90). [ENUM-REF-CANDIDATE: actual|normal|extreme_heat|extreme_cold|high_wind|low_wind|p10|p50|p90 — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_load PRIMARY KEY(`load_id`)
) COMMENT 'Core master entity representing a load forecast run and its interval-level forecast values for a specific horizon (short-term, day-ahead, seasonal, or long-term). Captures forecast type, target period, geographic scope (system-wide, zone, feeder), model version, weather scenario, and approval status at the header level. Stores forecasted MW demand at each time interval (hourly, 15-minute, or 5-minute resolution) with point forecast, confidence interval bounds (P10/P50/P90), and weather-adjusted values. Serves as the authoritative record for all load forecasting activity used in dispatch planning, procurement, and IRP. Sourced from EMS/ADMS load forecasting modules and integrated with OSIsoft PI historian data. Enables comparison against actual metered load from MDM for forecast accuracy tracking.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` (
    `load_forecast_interval_id` BIGINT COMMENT 'Unique identifier for each granular interval-level load forecast record. Primary key for the load forecast interval entity.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Interval-level load forecasts must reference the control area for real-time economic dispatch, unit commitment, and interchange scheduling. EMS systems use control-area-scoped interval forecasts for A',
    `forecast_run_id` BIGINT COMMENT 'Reference to the parent load forecast run that generated this interval forecast. Links this interval to the specific forecast execution batch, model version, and run parameters.',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Interval records belong to a specific load forecast run; linking to load enables aggregation and eliminates redundant to_load_forecast column.',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Load forecast intervals are built from aggregated historical consumption at service points. Forecasters trace meter points to calibrate zone-level models and assess accuracy. Real business process: fo',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Load forecast intervals include substation_code as a plain text denormalized field. Substation-level load forecasting is standard utility practice for transmission loading studies and distribution pla',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: load_forecast_interval stores temperature_forecast_f, humidity_forecast_percent, wind_speed_forecast_mph, and cloud_cover_forecast_percent as denormalized weather scalars at the interval level. Load f',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: load_forecast_interval stores zone_code as a denormalized STRING. Adding zone_id FK to the zone master table normalizes the geographic scope of each interval forecast record, enabling consistent zone-',
    `actual_load_mw` DECIMAL(18,2) COMMENT 'Actual metered load demand in megawatts for this interval, populated after the interval has occurred. Sourced from MDM interval data for forecast accuracy validation and model retraining.',
    `baseline_load_mw` DECIMAL(18,2) COMMENT 'Baseline or normal load level for this interval based on historical patterns, excluding demand response events or abnormal conditions. Used for demand response program settlement and load impact analysis.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level for the forecast interval bounds (typically 80% or 90%). Indicates the probability that actual load will fall within the P10-P90 range.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this load forecast interval record was first created in the system. Part of standard audit trail for data lineage and compliance.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for this forecast interval. Valid indicates high-confidence forecast; suspect indicates potential data quality issues; estimated indicates interpolated or imputed values; missing indicates no forecast available.. Valid values are `valid|suspect|estimated|missing`',
    `day_type` STRING COMMENT 'Classification of the forecast day as weekday, weekend, or holiday. Critical for load pattern recognition as commercial and industrial loads vary significantly by day type.. Valid values are `weekday|weekend|holiday`',
    `demand_response_adjustment_mw` DECIMAL(18,2) COMMENT 'Expected load reduction from scheduled demand response programs or events during this interval. Used for net load forecasting and resource adequacy calculations.',
    `der_adjustment_mw` DECIMAL(18,2) COMMENT 'Adjustment to the forecast for behind-the-meter distributed energy resources including rooftop solar, battery storage, and customer-sited generation. Represents net load reduction from DER output.',
    `ev_load_forecast_mw` DECIMAL(18,2) COMMENT 'Forecasted load contribution from electric vehicle charging during this interval. Tracked separately due to rapid EV adoption growth and managed charging program impacts.',
    `forecast_error_mw` DECIMAL(18,2) COMMENT 'Calculated forecast error when actual metered load becomes available. Computed as (actual_load_mw - point_forecast_mw). Used for forecast accuracy tracking and model tuning.',
    `forecast_error_percent` DECIMAL(18,2) COMMENT 'Forecast error expressed as a percentage of actual load. Calculated as ((actual_load_mw - point_forecast_mw) / actual_load_mw) * 100. Enables normalized accuracy comparison across different load levels.',
    `forecast_generation_timestamp` TIMESTAMP COMMENT 'Date and time when this forecast interval was generated by the forecasting system. Used for forecast lead time analysis and model performance evaluation.',
    `forecast_horizon_hours` STRING COMMENT 'Number of hours between forecast generation time and the forecasted interval. Used for lead-time-based accuracy analysis, as forecast accuracy typically degrades with longer horizons.',
    `forecast_status` STRING COMMENT 'Current status of this forecast interval record. Preliminary forecasts may be updated as weather forecasts improve; final forecasts are locked for operational use; revised forecasts incorporate corrections; superseded forecasts have been replaced by newer runs.. Valid values are `preliminary|final|revised|superseded`',
    `forecast_timestamp` TIMESTAMP COMMENT 'The specific date and time for which this load forecast applies. Represents the start of the forecast interval (hourly, 15-minute, or 5-minute resolution depending on forecast granularity).',
    `forecast_type` STRING COMMENT 'Classification of the forecast horizon. Short-term supports real-time operations, day-ahead supports market bidding, week-ahead supports unit commitment, seasonal supports resource planning, and long-term supports IRP and capacity expansion.. Valid values are `short_term|day_ahead|week_ahead|month_ahead|seasonal|long_term`',
    `interval_duration_minutes` STRING COMMENT 'Duration of the forecast interval in minutes. Common values include 60 (hourly), 15 (quarter-hourly), or 5 (five-minute) to support different operational and market requirements.',
    `model_name` STRING COMMENT 'Name or identifier of the forecasting model or algorithm used to generate this interval forecast (e.g., ARIMA, neural network, ensemble model). Enables model performance comparison and audit trail.',
    `model_version` STRING COMMENT 'Version identifier of the forecasting model used. Tracks model evolution and enables reproducibility of forecast results.',
    `notes` STRING COMMENT 'Free-text notes or comments about this forecast interval. May include explanations for unusual forecasts, data quality issues, special events, or operational context.',
    `p10_forecast_mw` DECIMAL(18,2) COMMENT 'Lower bound of the 80% confidence interval (10th percentile). Represents a conservative low-load scenario used for minimum generation planning and reserve margin calculations.',
    `p90_forecast_mw` DECIMAL(18,2) COMMENT 'Upper bound of the 80% confidence interval (90th percentile). Represents a high-load scenario used for capacity adequacy assessment and peak demand planning.',
    `peak_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this interval falls within a defined peak demand period. Used for peak demand planning, capacity market obligations, and critical peak pricing programs.',
    `point_forecast_mw` DECIMAL(18,2) COMMENT 'The primary forecasted load demand value in megawatts for this interval. Represents the expected (P50 or median) load level used for operational dispatch and resource scheduling.',
    `season` STRING COMMENT 'Meteorological or operational season classification. Used for seasonal load pattern analysis and rate period determination.. Valid values are `winter|spring|summer|fall`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this load forecast interval record was last modified. Tracks revisions to forecasts and actual load population for accuracy tracking.',
    `weather_adjusted_forecast_mw` DECIMAL(18,2) COMMENT 'Load forecast adjusted for actual or forecasted weather conditions including temperature, humidity, wind speed, and cloud cover. Used when weather deviates significantly from normal patterns.',
    `weather_station_code` STRING COMMENT 'Identifier of the primary weather station or weather forecast grid point used for this forecast. Enables traceability of weather data sources and regional weather correlation analysis.',
    CONSTRAINT pk_load_forecast_interval PRIMARY KEY(`load_forecast_interval_id`)
) COMMENT 'Granular interval-level load forecast values associated with a parent load forecast run. Stores forecasted MW demand at each time interval (hourly, 15-minute, or 5-minute resolution) for a specific zone, substation, or system aggregate. Includes point forecast, confidence interval bounds (P10/P50/P90), and weather-adjusted values. Enables comparison against actual metered load from MDM for forecast accuracy tracking.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` (
    `forecast_generation_id` BIGINT COMMENT 'Unique identifier for the forecast_generation data product.',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: Generation forecasts are produced by registered forecasting models. The model table is the authoritative registry for model configuration and performance metrics. Adding forecast_model_id FK allows re',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.run. Business justification: forecast_generation is the master record for generation output forecasts; generation_forecast_interval contains interval-level detail. Linking to run establishes the execution context. The run table c',
    `generating_unit_id` BIGINT COMMENT 'Reference to the generation asset, unit, or portfolio for which this forecast was produced. Links to the asset registry for the specific generating facility or aggregated portfolio.',
    `load_id` BIGINT COMMENT 'Unique identifier for the generation forecast run. Primary key for the forecast_generation product.',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Generation forecasts for distributed generation (rooftop solar, small wind) are tied to the meter_point where the DER is interconnected and metered. Required for NEM settlement reconciliation, grid im',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: forecast_generation stores ambient_temperature_c, solar_irradiance_w_per_m2, and wind_speed_mps as denormalized weather scalars, and weather_scenario as a STRING. Generation forecasts for thermal, sol',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: forecast_generation represents generation output forecasts that are geographically scoped to forecast zones. No zone FK currently exists on forecast_generation despite zone being the primary geographi',
    `actual_output_mw` DECIMAL(18,2) COMMENT 'The actual measured generation output in MW for this interval, populated after the fact from OSIsoft PI telemetry. Used for forecast accuracy assessment and model tuning.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'The forecasted ambient temperature in degrees Celsius for this interval. Affects thermal generation efficiency and renewable output (especially solar PV).',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'The generation capacity available for this forecast interval after accounting for scheduled maintenance, forced outages, and operational constraints. Represents the maximum achievable output for this period.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'The ratio of forecasted output to nameplate capacity expressed as a percentage. Indicates the expected utilization level of the generation asset for this interval.',
    `created_by_user` STRING COMMENT 'The user ID or system account that created this forecast record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was first created in the system. Used for audit trail and data lineage tracking.',
    `dispatch_schedule_flag` BOOLEAN COMMENT 'Indicates whether this forecast was used to create a unit commitment or dispatch schedule for operational control.',
    `forced_outage_flag` BOOLEAN COMMENT 'Indicates whether the generation asset is experiencing a forced outage during this forecast period. True if a forced outage has occurred, reducing available capacity.',
    `forecast_confidence_score` DECIMAL(18,2) COMMENT 'A confidence score (0-100) indicating the models confidence in this forecast. Higher scores indicate greater certainty; lower scores indicate higher uncertainty due to weather volatility, data quality issues, or model limitations.',
    `forecast_effective_end` TIMESTAMP COMMENT 'The end of the time period covered by this forecast. Defines the end of the forecast horizon. Nullable for open-ended long-term forecasts.',
    `forecast_effective_start` TIMESTAMP COMMENT 'The beginning of the time period covered by this forecast. Defines the start of the forecast horizon.',
    `forecast_error_mw` DECIMAL(18,2) COMMENT 'The difference between forecasted and actual output in MW (actual minus forecast). Positive values indicate under-forecast; negative values indicate over-forecast. Used for model performance evaluation.',
    `forecast_error_percent` DECIMAL(18,2) COMMENT 'The forecast error expressed as a percentage of actual output. Used for normalized accuracy comparison across different asset sizes and technologies.',
    `forecast_model_version` STRING COMMENT 'The version number of the forecasting model used. Enables tracking of model changes and performance improvements over time.',
    `forecast_run_identifier` STRING COMMENT 'Externally-known business identifier for this forecast run, typically used in operational communications and system integrations (e.g., ABB Symphony Plus run ID or OpenLink Endur forecast case name).',
    `forecast_status` STRING COMMENT 'Current lifecycle state of the forecast. Draft forecasts are under development; approved forecasts are released for operational use; active forecasts are currently in effect; superseded forecasts have been replaced by newer runs.. Valid values are `draft|pending_approval|approved|active|superseded|cancelled`',
    `forecast_type` STRING COMMENT 'Classification of the forecast by its planning horizon. Intraday supports real-time dispatch; day-ahead supports unit commitment and market bidding; week-ahead and longer horizons support resource adequacy and IRP (Integrated Resource Plan) scenario modeling. [ENUM-REF-CANDIDATE: intraday|day_ahead|week_ahead|month_ahead|seasonal|annual|irp_scenario — 7 candidates stripped; promote to reference product]',
    `forecasted_output_mw` DECIMAL(18,2) COMMENT 'The forecasted electrical generation output in megawatts (MW) for this interval. Represents the expected generation level for the asset or portfolio at this time.',
    `forecasted_output_mwh` DECIMAL(18,2) COMMENT 'The forecasted electrical energy output in megawatt-hours (MWh) for this interval. Calculated as MW output multiplied by interval duration.',
    `fuel_availability_status` STRING COMMENT 'The current fuel availability status for this forecast period. Constrained or limited fuel availability reduces forecasted output for fuel-dependent generation technologies.. Valid values are `normal|constrained|limited|unavailable|not_applicable`',
    `fuel_type` STRING COMMENT 'The primary fuel source for this generation asset. Used to apply fuel availability constraints and fuel cost assumptions in the forecast model. [ENUM-REF-CANDIDATE: natural_gas|coal|nuclear|hydro|wind|solar|biomass|diesel|fuel_oil|geothermal|not_applicable — 11 candidates stripped; promote to reference product]',
    `interval_duration_minutes` STRING COMMENT 'The time resolution of the forecast intervals in minutes (e.g., 5, 15, 60). Determines the granularity of forecasted MW output values.',
    `interval_timestamp` TIMESTAMP COMMENT 'The specific timestamp for this forecast interval. Each row may represent one interval within the forecast horizon, or the header may aggregate multiple intervals.',
    `market_bid_flag` BOOLEAN COMMENT 'Indicates whether this forecast was used as the basis for a market bid submission to an RTO (Regional Transmission Organization) or ISO (Independent System Operator) day-ahead or real-time market.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'The maximum rated generation capacity of the asset or portfolio in MW under ideal conditions. Used as the baseline for capacity factor calculations and constraint modeling.',
    `notes` STRING COMMENT 'Free-text notes or comments about this forecast run, including assumptions, special conditions, or operational context that influenced the forecast.',
    `p10_output_mw` DECIMAL(18,2) COMMENT 'The 10th percentile probabilistic forecast bound in MW. Represents a conservative lower bound with 90% probability that actual output will exceed this value. Used for risk assessment and reserve planning.',
    `p50_output_mw` DECIMAL(18,2) COMMENT 'The 50th percentile (median) probabilistic forecast in MW. Represents the most likely generation output with equal probability of actual output being above or below this value.',
    `p90_output_mw` DECIMAL(18,2) COMMENT 'The 90th percentile probabilistic forecast bound in MW. Represents an optimistic upper bound with 90% probability that actual output will be below this value. Used for capacity planning and market bidding.',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'The maximum rate at which the generation asset can increase or decrease output, expressed in MW per minute. Used for AGC (Automatic Generation Control) setpoint planning and dispatch scheduling.',
    `scheduled_maintenance_flag` BOOLEAN COMMENT 'Indicates whether the generation asset has scheduled maintenance during this forecast period. True if maintenance is scheduled, reducing available capacity.',
    `solar_irradiance_w_per_m2` DECIMAL(18,2) COMMENT 'The forecasted solar irradiance in watts per square meter for this interval. Primary input for solar generation forecasts.',
    `source_system` STRING COMMENT 'The name or identifier of the source system that generated this forecast (e.g., ABB Symphony Plus, OpenLink Endur, internal forecasting platform). Used for data lineage and integration troubleshooting.',
    `technology` STRING COMMENT 'The primary generation technology type for the forecasted asset or portfolio. Used to apply technology-specific forecast models (e.g., renewable intermittency for wind/solar, fuel availability for CCGT, hydrological models for hydro). [ENUM-REF-CANDIDATE: ccgt|simple_cycle_gas|coal|nuclear|hydro|wind|solar_pv|solar_thermal|biomass|geothermal|energy_storage|other — 12 candidates stripped; promote to reference product]',
    `updated_by_user` STRING COMMENT 'The user ID or system account that last modified this forecast record. Used for accountability and audit purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was last modified. Used for audit trail and change tracking.',
    `weather_scenario` STRING COMMENT 'Identifier for the weather scenario or weather forecast model used as input to this generation forecast. Critical for renewable generation forecasts that depend on wind speed, solar irradiance, and temperature.',
    `wind_speed_mps` DECIMAL(18,2) COMMENT 'The forecasted wind speed in meters per second for this interval. Primary input for wind generation forecasts.',
    CONSTRAINT pk_forecast_generation PRIMARY KEY(`forecast_generation_id`)
) COMMENT 'Core master entity representing a generation output forecast run and its interval-level forecast values for a specific generation asset, portfolio, or system total. Captures forecast horizon (intraday, day-ahead, week-ahead), generation technology type (CCGT, wind, solar, hydro, nuclear), fuel availability assumptions, and scheduled maintenance constraints at the header level. Stores forecasted MW output per generation unit or portfolio at each time interval, including probabilistic bounds (P10/P50/P90), ramp rate constraints, and fuel-adjusted capacity. Used by dispatch schedulers and energy traders for unit commitment, market bidding, AGC setpoint planning, and real-time dispatch scheduling. Integrates with ABB Symphony Plus and OpenLink Endur. Compared against actual generation telemetry from OSIsoft PI for model accuracy assessment.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` (
    `generation_forecast_interval_id` BIGINT COMMENT 'Unique identifier for the generation forecast interval record. Primary key for this entity.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Generation forecasts are dispatched within control area boundaries for ACE calculation, net interchange scheduling, and frequency regulation. Control area operators use generation forecasts to plan re',
    `forecast_generation_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_generation. Business justification: Generation forecast intervals are child records of a generation forecast master; FK provides proper hierarchy.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generation unit or asset for which this interval forecast applies. May represent a single turbine, generator, solar array, or aggregated portfolio depending on forecast granularity.',
    `forecast_run_id` BIGINT COMMENT 'Reference to the parent generation forecast run that produced this interval forecast. Links this interval to the overall forecast execution context including model version, execution timestamp, and forecast horizon.',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: generation_forecast_interval stores weather_temperature_celsius, solar_irradiance_w_per_m2, cloud_cover_percent, precipitation_probability_percent, and wind_speed_mps as denormalized weather scalars a',
    `actual_mw_output` DECIMAL(18,2) COMMENT 'The actual measured generation output in megawatts for this interval, populated from SCADA telemetry or OSIsoft PI historian. Used for forecast accuracy validation and model tuning.',
    `agc_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether this generation unit is eligible and available for Automatic Generation Control during this interval. AGC-eligible units can respond to real-time frequency regulation signals.',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'The maximum generation capacity available for this unit during the interval, accounting for planned outages, derates, and operational constraints. Represents the upper bound for feasible generation output.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'The forecasted capacity factor for this interval, calculated as forecast MW output divided by nameplate capacity, expressed as a percentage. Indicates the expected utilization level of the generation asset.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast interval record was first created in the system. Supports audit trail and data lineage tracking.',
    `curtailment_risk_flag` BOOLEAN COMMENT 'Boolean indicator of whether this interval forecast is at risk of curtailment due to transmission constraints, negative pricing, or oversupply conditions. Primarily applies to renewable generation.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality and reliability of the forecast data for this interval. Valid indicates high-quality forecast, estimated indicates interpolated values, missing indicates no forecast available, suspect indicates potential data issues, override indicates manual adjustment.. Valid values are `valid|estimated|missing|suspect|override`',
    `dispatch_priority_rank` STRING COMMENT 'The relative dispatch priority ranking for this generation unit during this interval. Lower numbers indicate higher priority. Based on economic merit order, must-run status, and operational constraints.',
    `forecast_confidence_score` DECIMAL(18,2) COMMENT 'A numerical confidence score representing the forecast models certainty in the predicted output, typically expressed as a percentage (0-100). Higher scores indicate greater confidence based on historical accuracy, weather data quality, and model convergence.',
    `forecast_error_mw` DECIMAL(18,2) COMMENT 'The calculated forecast error in megawatts, populated after actual generation data is available. Represents the difference between forecasted and actual output. Used for model accuracy assessment and continuous improvement.',
    `forecast_error_percent` DECIMAL(18,2) COMMENT 'The calculated forecast error expressed as a percentage of actual output. Provides a normalized accuracy metric that enables comparison across different generation units and capacity levels.',
    `forecast_horizon_hours` STRING COMMENT 'The number of hours ahead from the forecast run timestamp to this interval. Represents the lead time of the forecast. Forecast accuracy typically degrades with longer horizons.',
    `forecast_model_version` STRING COMMENT 'The version identifier of the forecasting model or algorithm used to generate this interval forecast. Enables model performance tracking, A/B testing, and forecast accuracy attribution.',
    `forecast_mw_output` DECIMAL(18,2) COMMENT 'The forecasted generation output in megawatts for this interval. Represents the expected power production from the generation unit during the interval. Primary value used for unit commitment, dispatch scheduling, and AGC setpoint planning.',
    `forecast_mwh_energy` DECIMAL(18,2) COMMENT 'The forecasted energy production in megawatt-hours for this interval. Calculated as forecast MW output multiplied by interval duration. Used for energy market bidding, settlement, and resource adequacy planning.',
    `forecast_type` STRING COMMENT 'The classification of the forecast based on its time horizon and operational purpose. Day-ahead forecasts support market bidding, hour-ahead supports dispatch scheduling, real-time supports AGC, and seasonal supports IRP planning.. Valid values are `day_ahead|hour_ahead|real_time|week_ahead|seasonal`',
    `fuel_consumption_rate` DECIMAL(18,2) COMMENT 'The forecasted fuel consumption rate for this interval, expressed in fuel-specific units (e.g., MMBtu/hour for gas, tons/hour for coal). Used for fuel procurement planning, cost estimation, and emissions calculation.',
    `fuel_type` STRING COMMENT 'The primary fuel or energy source used by the generation unit for this forecast interval. Determines dispatch priority, emissions profile, and operational characteristics. [ENUM-REF-CANDIDATE: coal|natural_gas|nuclear|hydro|wind|solar|biomass|geothermal — 8 candidates stripped; promote to reference product]',
    `gen_interval_to_gen_forecast` BIGINT COMMENT 'FK to forecast.forecast_generation_forecast.forecast_generation_forecast_id — Every generation forecast interval MUST reference its parent generation forecast. Core header-to-line FK required for dispatch scheduling and unit commitment.',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'The forecasted heat rate for this interval, representing the amount of fuel energy input (in BTU) required to produce one kilowatt-hour of electrical output. Lower values indicate higher thermal efficiency.',
    `interval_duration_minutes` STRING COMMENT 'The duration of the forecast interval in minutes. Common values include 5, 15, 30, or 60 minutes depending on forecast granularity and market requirements. Supports validation of interval alignment and aggregation logic.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'The ending timestamp of the forecast interval. Defines the end of the time window for which the forecasted generation output applies. Used to calculate interval duration and align with market settlement periods.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'The beginning timestamp of the forecast interval. Defines the start of the time window for which the forecasted generation output applies. Typically aligned to standard market intervals (5-min, 15-min, 1-hour).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast interval record was most recently modified. Tracks forecast revisions and actual data backfill operations.',
    `must_run_flag` BOOLEAN COMMENT 'Boolean indicator of whether this generation unit is designated as must-run for this interval due to reliability, contractual, or regulatory requirements. Must-run units are dispatched regardless of economic merit.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'The rated maximum continuous output capacity of the generation unit as specified by the manufacturer. Used as a reference baseline for capacity factor calculations and performance assessment.',
    `p10_mw_output` DECIMAL(18,2) COMMENT 'The 10th percentile probabilistic forecast output in megawatts. Represents a conservative lower bound with 90% probability that actual output will exceed this value. Used for risk assessment and reserve planning.',
    `p50_mw_output` DECIMAL(18,2) COMMENT 'The 50th percentile probabilistic forecast output in megawatts. Represents the median expected output with equal probability of actual output being above or below. Typically used as the base case forecast for operational planning.',
    `p90_mw_output` DECIMAL(18,2) COMMENT 'The 90th percentile probabilistic forecast output in megawatts. Represents an optimistic upper bound with 90% probability that actual output will be below this value. Used for upside scenario planning and capacity credit assessment.',
    `ramp_constraint_flag` BOOLEAN COMMENT 'Boolean indicator of whether this interval forecast is subject to ramp rate constraints. True indicates that physical or operational limits on ramp speed apply and must be respected in dispatch optimization.',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'The forecasted rate of change in generation output in megawatts per minute. Represents the expected ramp-up or ramp-down speed, critical for AGC response, frequency regulation, and dispatch feasibility assessment.',
    `source_system` STRING COMMENT 'The name or identifier of the source system that generated this forecast interval record. Examples include proprietary forecasting platforms, vendor solutions, or internal modeling systems.',
    `variance_explanation_code` STRING COMMENT 'A categorical code explaining the primary reason for significant forecast variance when actual output deviates materially from forecast. Supports root cause analysis and model improvement initiatives.. Valid values are `weather_deviation|forced_outage|curtailment|fuel_constraint|transmission_limit|model_error`',
    CONSTRAINT pk_generation_forecast_interval PRIMARY KEY(`generation_forecast_interval_id`)
) COMMENT 'Interval-level generation output forecast values for a parent generation forecast run. Stores forecasted MW output per generation unit or portfolio at each time interval, including probabilistic bounds (P10/P50/P90), ramp rate constraints, and fuel-adjusted capacity. Supports unit commitment optimization, AGC setpoint planning, and real-time dispatch scheduling. Compared against actual generation telemetry from OSIsoft PI for model accuracy assessment.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` (
    `forecast_renewable_id` BIGINT COMMENT 'Unique identifier for the forecast_renewable data product.',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: Renewable forecasts are produced by registered forecasting models. The model table is the authoritative registry for model configuration, hyperparameters, and validation metrics. Adding forecast_model',
    `operating_limit_id` BIGINT COMMENT 'Foreign key linking to grid.operating_limit. Business justification: Renewable forecasts flag transmission_constraint_flag as a boolean denormalization. Linking to the specific operating_limit enables curtailment planning, interconnection queue analysis, and transmissi',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Renewable generation forecasts are tied to their grid interconnection point, which is a pnode in RTO/ISO markets. The forecast_renewable product has interconnection_point as a plain text denormalized ',
    `ppa_id` BIGINT COMMENT 'Reference to the Power Purchase Agreement (PPA) contract governing the commercial terms for this renewable asset. Used for revenue forecasting and RPS compliance tracking.',
    `forecast_run_id` BIGINT COMMENT 'Unique identifier for the renewable energy forecast record. Primary key for the forecast_renewable product.',
    `registry_id` BIGINT COMMENT 'Reference to the renewable generation asset (wind farm, solar PV plant, run-of-river hydro facility) for which this forecast applies.',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: forecast_renewable stores weather_model_source as a denormalized STRING. Renewable energy forecasting (solar, wind) is fundamentally driven by weather inputs from NWP models. Adding weather_input_id F',
    `zone_id` BIGINT COMMENT 'Reference to the aggregate balancing zone, pricing node (PNode), or geographic region for which this forecast applies. Used for portfolio-level or zonal forecasts.',
    `actual_mw` DECIMAL(18,2) COMMENT 'The actual measured power output in megawatts (MW) for the forecast period, populated after the fact. Used for forecast accuracy evaluation and model tuning. Null until actual data is available.',
    `aggregation_level` STRING COMMENT 'The level of geographic or organizational aggregation for this forecast. Asset-level forecasts support individual plant operations; portfolio and zone-level forecasts support market participation and grid operations.. Valid values are `asset|portfolio|zone|balancing_authority|iso_rto`',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'The available generation capacity in megawatts (MW) after accounting for planned and unplanned outages, derates, and maintenance. Represents the maximum achievable output during the forecast period.',
    `capacity_factor_forecast` DECIMAL(18,2) COMMENT 'The forecasted capacity factor (ratio of actual output to nameplate capacity) for the renewable asset during the forecast period. Expressed as a decimal (e.g., 0.3500 = 35%).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was first created in the system. Used for audit trails and data lineage tracking.',
    `curtailment_mw` DECIMAL(18,2) COMMENT 'Forecasted curtailment in megawatts (MW) due to grid constraints, negative pricing, or dispatch instructions. Represents the reduction from potential output.',
    `curtailment_probability` DECIMAL(18,2) COMMENT 'The probability (0.0000 to 1.0000) that curtailment will occur during the forecast period. Used for risk assessment and revenue forecasting.',
    `data_source_system` STRING COMMENT 'The name of the source system or forecasting platform that generated this forecast record. Examples: proprietary forecasting engine, third-party weather service, Energy Management System (EMS), Distributed Energy Resource Management System (DERMS).',
    `forecast_confidence_score` DECIMAL(18,2) COMMENT 'A confidence score (0.0000 to 1.0000) representing the forecasting models certainty in the prediction. Higher scores indicate more stable weather patterns and higher forecast reliability.',
    `forecast_error_mw` DECIMAL(18,2) COMMENT 'The difference between forecasted and actual power output in megawatts (MW). Calculated as (actual_mw - forecasted_mw_p50). Used for model performance tracking and continuous improvement.',
    `forecast_error_percentage` DECIMAL(18,2) COMMENT 'The forecast error expressed as a percentage of nameplate capacity. Calculated as (forecast_error_mw / nameplate_capacity_mw) * 100. Key performance indicator for forecast quality.',
    `forecast_horizon_end` TIMESTAMP COMMENT 'The ending timestamp of the forecast period. Defines the end of the interval-level forecast data.',
    `forecast_horizon_start` TIMESTAMP COMMENT 'The beginning timestamp of the forecast period. Defines the start of the interval-level forecast data.',
    `forecast_notes` STRING COMMENT 'Free-text field for additional context, assumptions, or special conditions affecting this forecast. Examples: extreme weather events, planned maintenance, model adjustments, data quality issues.',
    `forecast_status` STRING COMMENT 'The lifecycle status of the forecast record. Published forecasts are used for operational decisions; superseded forecasts have been replaced by newer runs; archived forecasts are retained for historical analysis.. Valid values are `draft|published|superseded|archived`',
    `forecast_type` STRING COMMENT 'Classification of the forecast by time horizon and operational purpose. Day-ahead supports market bidding, hour-ahead supports dispatch, intraday supports real-time balancing, seasonal supports Integrated Resource Plan (IRP) and capacity planning.. Valid values are `day_ahead|hour_ahead|week_ahead|intraday|real_time|seasonal`',
    `forecast_use_case` STRING COMMENT 'The primary operational or planning use case for this forecast. Determines the required accuracy, granularity, and update frequency. RPS = Renewable Portfolio Standard, VPP = Virtual Power Plant.. Valid values are `dispatch|market_bidding|rps_compliance|grid_balancing|capacity_planning|vpp_optimization`',
    `forecasted_mw_p10` DECIMAL(18,2) COMMENT 'The 10th percentile forecasted power output in megawatts (MW). Represents a conservative lower bound with 90% probability of exceedance. Used for risk management and reserve planning.',
    `forecasted_mw_p50` DECIMAL(18,2) COMMENT 'The median (50th percentile) forecasted power output in megawatts (MW) for the renewable asset. Represents the most likely generation level.',
    `forecasted_mw_p90` DECIMAL(18,2) COMMENT 'The 90th percentile forecasted power output in megawatts (MW). Represents an optimistic upper bound with 10% probability of exceedance. Used for upside scenario planning.',
    `forecasted_rec_quantity` DECIMAL(18,2) COMMENT 'The forecasted quantity of Renewable Energy Certificates (RECs) that will be generated from the forecasted MWh output. Typically 1 REC per MWh of eligible generation.',
    `interval_duration_minutes` STRING COMMENT 'The granularity of the forecast intervals in minutes. Common values are 5, 15, 30, or 60 minutes depending on operational requirements and market settlement intervals.',
    `irradiance_w_per_m2` DECIMAL(18,2) COMMENT 'Forecasted solar irradiance in watts per square meter (W/m²) for solar PV assets. Null for non-solar technologies. Key meteorological input for solar generation forecasting.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'The maximum rated power output capacity of the renewable asset in megawatts (MW) under standard test conditions. Used for capacity factor calculations and normalization.',
    `ramp_event_probability` DECIMAL(18,2) COMMENT 'The probability (0.0000 to 1.0000) that a significant ramp event (rapid increase or decrease in output) will occur during the forecast period. Used for reserve planning.',
    `ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'Forecasted rate of change in power output in megawatts per minute (MW/min). Critical for grid balancing and reserve requirements during rapid weather changes.',
    `rec_eligible_flag` BOOLEAN COMMENT 'Indicates whether the forecasted generation is eligible for Renewable Energy Certificate (REC) creation under applicable Renewable Portfolio Standard (RPS) programs. True if eligible, False otherwise.',
    `technology` STRING COMMENT 'The type of variable renewable energy (VRE) technology for which the forecast is generated. Determines the meteorological inputs and intermittency characteristics.. Valid values are `solar_pv|wind_onshore|wind_offshore|hydro_run_of_river|hybrid`',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Forecasted ambient temperature in degrees Celsius at the asset location. Affects solar panel efficiency and wind turbine performance.',
    `transmission_constraint_flag` BOOLEAN COMMENT 'Indicates whether transmission constraints are expected to limit the renewable assets output during the forecast period. True if constraints are forecasted, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this forecast record was last modified. Used for audit trails and change tracking.',
    `wind_speed_m_per_s` DECIMAL(18,2) COMMENT 'Forecasted wind speed in meters per second (m/s) at hub height for wind assets. Null for non-wind technologies. Key meteorological input for wind generation forecasting.',
    CONSTRAINT pk_forecast_renewable PRIMARY KEY(`forecast_renewable_id`)
) COMMENT 'Master record and interval-level forecast values for variable renewable energy (VRE) covering utility-scale wind, solar PV, and run-of-river hydro resources. Captures intermittency prediction parameters, irradiance and wind speed inputs, curtailment risk, and ramp event probability at the header level. Stores forecasted MW output per renewable asset or aggregate zone at each time interval, including irradiance (W/m²), wind speed (m/s), capacity factor, curtailment MW, and probabilistic confidence bands (P10/P50/P90). Supports RPS compliance planning, VPP dispatch optimization, real-time renewable integration management, and grid balancing decisions.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` (
    `renewable_forecast_interval_id` BIGINT COMMENT 'Unique identifier for the renewable forecast interval record. Primary key for this entity.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Renewable generation forecasts feed into control area AGC signals, regulation reserve requirements, and ramp management. High renewable penetration requires control-area-level forecast integration for',
    `forecast_renewable_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_renewable. Business justification: Renewable forecast intervals are child records of a renewable forecast master; FK creates correct parent-child relationship.',
    `operating_limit_id` BIGINT COMMENT 'Foreign key linking to grid.operating_limit. Business justification: Renewable forecast intervals flag grid_constraint_flag indicating transmission constraints. The specific operating_limit causing curtailment must be referenced for interconnection studies, curtailment',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Renewable forecast intervals include locational_marginal_price_usd_per_mwh — the LMP at the generation pnode. Curtailment decisions, settlement, and congestion analysis for renewable resources require',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the specific renewable generation asset (solar farm, wind farm, or aggregated zone) for which this interval forecast applies.',
    `forecast_run_id` BIGINT COMMENT 'Foreign key reference to the parent renewable forecast run that generated this interval forecast. Links this interval to the overall forecast execution context.',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: renewable_forecast_interval stores forecasted_cloud_cover_percent, forecasted_irradiance_w_per_m2, forecasted_temperature_celsius, forecasted_wind_direction_degrees, and forecasted_wind_speed_m_per_s ',
    `aggregation_level` STRING COMMENT 'The geographic or organizational level at which this forecast is aggregated. Asset-level forecasts are for individual facilities, zone-level aggregates multiple assets, portfolio covers all renewable assets, balancing authority represents the entire control area.. Valid values are `asset|zone|portfolio|balancing_authority`',
    `confidence_level_p10_mw` DECIMAL(18,2) COMMENT 'The 10th percentile probabilistic forecast value in megawatts. Represents a conservative lower bound with 90% probability that actual generation will exceed this value. Used for risk management and reserve planning.',
    `confidence_level_p50_mw` DECIMAL(18,2) COMMENT 'The 50th percentile (median) probabilistic forecast value in megawatts. Represents the most likely generation outcome with equal probability of over or under-performance.',
    `confidence_level_p90_mw` DECIMAL(18,2) COMMENT 'The 90th percentile probabilistic forecast value in megawatts. Represents an optimistic upper bound with 90% probability that actual generation will be below this value. Used for upside scenario planning.',
    `data_source_system` STRING COMMENT 'The name or identifier of the operational system that generated this forecast record (e.g., OSIsoft PI, proprietary forecasting platform, SCADA system). Enables data lineage tracking and system integration management.',
    `forecast_bias_mw` DECIMAL(18,2) COMMENT 'The systematic bias adjustment applied to the raw model output based on historical forecast error analysis. Positive values indicate upward adjustment, negative values indicate downward adjustment.',
    `forecast_created_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast interval record was generated and persisted to the system. Used for audit trails and to calculate forecast lead time.',
    `forecast_horizon_hours` STRING COMMENT 'The number of hours ahead from the forecast run time that this interval represents. Used to analyze forecast accuracy degradation over time and distinguish short-term from long-term forecasts.',
    `forecast_interval_end_timestamp` TIMESTAMP COMMENT 'The end date and time of the forecast interval. Represents the conclusion of the time window for which the generation forecast applies.',
    `forecast_interval_start_timestamp` TIMESTAMP COMMENT 'The start date and time of the forecast interval. Represents the beginning of the time window for which the generation forecast applies. Critical for time-series alignment in grid operations.',
    `forecast_model_version` STRING COMMENT 'The version identifier of the forecasting model or algorithm used to generate this interval prediction. Enables traceability and model performance analysis.',
    `forecast_quality_flag` STRING COMMENT 'Data quality indicator for this forecast interval. Valid indicates normal forecast, suspect indicates potential issues, estimated indicates fallback methodology used, missing_input indicates incomplete weather data, model_failure indicates computational error.. Valid values are `valid|suspect|estimated|missing_input|model_failure`',
    `forecast_type` STRING COMMENT 'The classification of the forecast based on its time horizon and operational purpose. Day-ahead forecasts support market bidding, hour-ahead supports dispatch, real-time supports balancing operations.. Valid values are `day_ahead|hour_ahead|real_time|week_ahead|month_ahead`',
    `forecast_uncertainty_mw` DECIMAL(18,2) COMMENT 'The standard deviation or uncertainty range of the forecast in megawatts. Quantifies the expected variability around the point forecast. Higher values indicate greater forecast uncertainty.',
    `forecast_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast interval record was last modified or refreshed. Null if the record has never been updated after initial creation.',
    `forecasted_capacity_factor` DECIMAL(18,2) COMMENT 'The predicted ratio of actual generation to nameplate capacity for this interval, expressed as a decimal between 0 and 1. Indicates expected asset utilization relative to maximum rated output.',
    `forecasted_curtailment_mw` DECIMAL(18,2) COMMENT 'The predicted amount of renewable generation that will be curtailed (not dispatched) in megawatts due to grid constraints, negative pricing, or operational limits. Zero indicates no expected curtailment.',
    `forecasted_generation_mw` DECIMAL(18,2) COMMENT 'The predicted electrical generation output in megawatts for this interval. This is the primary forecast value used by grid operators for dispatch and balancing decisions.',
    `grid_constraint_flag` BOOLEAN COMMENT 'Boolean indicator of whether transmission or distribution grid constraints are expected to limit renewable generation dispatch during this interval. True indicates constraints are forecasted, False indicates no constraints expected.',
    `interval_duration_minutes` STRING COMMENT 'The duration of the forecast interval in minutes. Common values include 5, 15, 30, or 60 minutes depending on operational requirements and forecast granularity.',
    `locational_marginal_price_usd_per_mwh` DECIMAL(18,2) COMMENT 'The forecasted locational marginal price at the renewable asset point of interconnection in USD per MWh. Reflects local grid congestion and transmission constraints. Used for economic dispatch optimization.',
    `market_clearing_price_usd_per_mwh` DECIMAL(18,2) COMMENT 'The forecasted or actual wholesale electricity market price in USD per MWh for this interval. Used to calculate expected revenue and inform economic curtailment decisions. May be null for non-market forecasts.',
    `net_generation_mw` DECIMAL(18,2) COMMENT 'The predicted net generation output after accounting for curtailment. Calculated as forecasted_generation_mw minus forecasted_curtailment_mw. Represents the actual expected dispatch to the grid.',
    `persistence_forecast_mw` DECIMAL(18,2) COMMENT 'A simple baseline forecast assuming current generation continues unchanged. Used as a benchmark to evaluate the skill and value-add of advanced forecasting models.',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'The predicted rate of change in generation output in megawatts per minute from the previous interval. Critical for grid stability analysis and reserve requirement calculations. Positive values indicate increasing generation, negative values indicate decreasing generation.',
    `renewable_interval_to_renewable_forecast` BIGINT COMMENT 'FK to forecast.renewable_forecast.renewable_forecast_id — Every renewable forecast interval MUST reference its parent renewable forecast. Required for real-time renewable integration and grid balancing.',
    `renewable_technology_type` STRING COMMENT 'The type of renewable generation technology for which this forecast applies. Different technologies require different forecasting methodologies and meteorological inputs.. Valid values are `solar_pv|wind_onshore|wind_offshore|hydro_run_of_river|biomass|geothermal`',
    `weather_data_source` STRING COMMENT 'The name or identifier of the meteorological data provider used as input for this forecast (e.g., NOAA, ECMWF, proprietary weather service). Critical for forecast quality assessment and vendor management.',
    CONSTRAINT pk_renewable_forecast_interval PRIMARY KEY(`renewable_forecast_interval_id`)
) COMMENT 'Interval-level renewable generation forecast values for a parent renewable forecast run. Stores forecasted MW output per renewable asset or aggregate zone at each time interval, including irradiance (W/m²), wind speed (m/s), capacity factor, curtailment MW, and probabilistic confidence bands. Enables real-time renewable integration management and grid balancing decisions by grid operators.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` (
    `peak_demand_id` BIGINT COMMENT 'Primary key for peak_demand',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Peak demand forecasts drive control area capacity planning, reserve margin calculations, and resource adequacy assessments. Balancing authorities use peak forecasts for transmission planning and gener',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: Peak demand forecasts are produced by registered forecasting models. The model table is the authoritative registry for model metadata, versioning, and accuracy metrics. Adding forecast_model_id FK all',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_run. Business justification: peak_demand is a forecast product produced by a forecast model run, yet it has no FK to forecast_run. All other forecast products (load, forecast_generation, forecast_renewable, energy_price, accuracy',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Peak demand forecasts used in IRP filings and capacity planning must be validated against actual peak readings at specific meter points. Utility planners and regulators require traceability from forec',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Peak demand forecasts are spatially scoped to forecast zones. The zone table defines geographic boundaries and aggregation levels. Adding forecast_zone_id FK allows retrieval of zone_code, zone_name, ',
    `weather_input_id` BIGINT COMMENT 'Foreign key linking to forecast.weather_input. Business justification: peak_demand stores weather_station_code as a denormalized STRING and forecasted_temperature as a scalar. Peak demand forecasting is highly weather-sensitive (temperature-driven). Adding weather_input_',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this peak demand forecast for use in resource adequacy and capacity planning.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this peak demand forecast was approved by planning or management for use in resource adequacy and capacity planning.',
    `btm_solar_reduction_mw` DECIMAL(18,2) COMMENT 'Forecasted behind-the-meter (BTM) solar generation reduction credit in megawatts (MW) that will reduce the net peak demand seen by the grid.',
    `capex_trigger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast triggers capital expenditure (CAPEX) investment decisions for transmission and distribution (T&D) infrastructure (True if triggers investment, False otherwise).',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level of the forecast expressed as a percentage (e.g., 90.0 for 90% confidence interval). Indicates forecast reliability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this peak demand forecast record was first created in the system.',
    `dr_reduction_mw` DECIMAL(18,2) COMMENT 'Forecasted demand response (DR) program reduction credit in megawatts (MW) that will reduce the gross peak demand. Used for resource adequacy calculations.',
    `energy_efficiency_reduction_mw` DECIMAL(18,2) COMMENT 'Forecasted energy efficiency program reduction credit in megawatts (MW) that will reduce the gross peak demand due to efficiency measures.',
    `forecast_error_mw` DECIMAL(18,2) COMMENT 'Expected forecast error or uncertainty range in megawatts (MW). Represents the plus/minus range around the forecasted peak demand.',
    `forecast_horizon` STRING COMMENT 'Time horizon classification for the forecast (short-term operational, seasonal, annual, multi-year, or long-term capacity planning).. Valid values are `short_term|seasonal|annual|multi_year|long_term`',
    `forecast_name` STRING COMMENT 'Business-friendly name or label for this peak demand forecast (e.g., Summer 2024 System Peak, Winter 2025 Coincident Peak).',
    `forecast_notes` STRING COMMENT 'Free-text notes, assumptions, or commentary related to this peak demand forecast. May include special conditions, data quality issues, or planning considerations.',
    `forecast_scenario` STRING COMMENT 'Planning scenario or case assumption underlying this forecast (base case, high growth, low growth, extreme weather, conservation, electrification).. Valid values are `base_case|high_growth|low_growth|extreme_weather|conservation|electrification`',
    `forecast_season` STRING COMMENT 'Seasonal period for which the peak demand is forecasted (summer, winter, spring, fall, or annual).. Valid values are `summer|winter|spring|fall|annual`',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the peak demand forecast (draft, submitted to RTO/ISO, approved by planning, revised, or archived).. Valid values are `draft|submitted|approved|revised|archived`',
    `forecast_type` STRING COMMENT 'Classification of the peak demand forecast by scope and aggregation level (system-wide, coincident across zones, non-coincident, zonal, substation-level, or feeder-level).. Valid values are `system_peak|coincident_peak|non_coincident_peak|zonal_peak|substation_peak|feeder_peak`',
    `forecast_year` STRING COMMENT 'Calendar year for which the peak demand is forecasted.',
    `forecasted_temperature` DECIMAL(18,2) COMMENT 'Forecasted temperature (in degrees Fahrenheit or Celsius) at the time of peak demand. Used for weather-correlated load forecasting.',
    `irp_filing_date` DATE COMMENT 'Date on which the IRP containing this forecast was filed with the state Public Utility Commission.',
    `irp_filing_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast is included in an Integrated Resource Plan (IRP) filing to the state Public Utility Commission (True if included, False otherwise).',
    `modified_by` STRING COMMENT 'User ID or name of the person or system that last modified this peak demand forecast record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this peak demand forecast record was last modified or updated.',
    `mw` DECIMAL(18,2) COMMENT 'Forecasted system peak demand in megawatts (MW). This is the principal quantitative value representing the maximum expected load.',
    `net_peak_demand_mw` DECIMAL(18,2) COMMENT 'Net forecasted peak demand in megawatts (MW) after applying all reduction credits (demand response, BTM solar, energy efficiency). This is the load the utility must serve.',
    `normal_temperature` DECIMAL(18,2) COMMENT 'Normal or baseline temperature assumption (in degrees Fahrenheit or Celsius) used as the reference point for temperature sensitivity calculations.',
    `peak_date` DATE COMMENT 'Forecasted date on which the peak demand is expected to occur.',
    `peak_hour_end` STRING COMMENT 'Ending hour (0-23) of the forecasted peak demand window. Used for operational dispatch planning.',
    `peak_hour_start` STRING COMMENT 'Starting hour (0-23) of the forecasted peak demand window. Used for operational dispatch planning.',
    `required_capacity_mw` DECIMAL(18,2) COMMENT 'Total required generation capacity in megawatts (MW) calculated as net peak demand plus reserve margin. Used for resource adequacy and capacity procurement planning.',
    `reserve_margin_percent` DECIMAL(18,2) COMMENT 'Planning reserve margin percentage applied to the net peak demand to determine required generation capacity. Expressed as a percentage (e.g., 15.0 for 15%).',
    `rto_iso_submission_date` DATE COMMENT 'Date on which this forecast was submitted to the RTO/ISO for capacity planning and reliability assessments.',
    `rto_iso_submission_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast has been submitted to the RTO/ISO for capacity planning and reliability assessments (True if submitted, False otherwise).',
    `temperature_sensitivity_mw_per_degree` DECIMAL(18,2) COMMENT 'Temperature sensitivity coefficient representing the change in peak demand (MW) per degree Fahrenheit or Celsius change from normal. Used for weather-adjusted forecasting.',
    `temperature_unit` STRING COMMENT 'Unit of measure for temperature sensitivity (Fahrenheit or Celsius).. Valid values are `fahrenheit|celsius`',
    `created_by` STRING COMMENT 'User ID or name of the person or system that created this peak demand forecast record.',
    CONSTRAINT pk_peak_demand PRIMARY KEY(`peak_demand_id`)
) COMMENT 'Master entity capturing seasonal and annual peak demand forecasts used for resource adequacy planning, transmission planning, and IRP. Records forecasted system peak MW, coincident peak date/time window, temperature sensitivity assumptions, demand response reduction credits, and reserve margin calculations. Submitted to RTO/ISO for capacity planning and NERC reliability assessments. Supports CAPEX investment decisions for T&D infrastructure.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`weather_input` (
    `weather_input_id` BIGINT COMMENT 'Primary key for weather_input',
    `zone_id` BIGINT COMMENT 'Identifier for the geographic zone or service territory to which this weather forecast applies. Links to the zone definition used in load and generation forecasting models.',
    `atmospheric_pressure_hpa` DECIMAL(18,2) COMMENT 'Forecasted atmospheric pressure at sea level in hectopascals (hPa). Used in advanced weather correlation models and can influence wind patterns and storm tracking.',
    `cloud_cover_percent` DECIMAL(18,2) COMMENT 'Forecasted total cloud cover as a percentage (0-100). Primary driver of solar irradiance reduction and solar generation output forecasting.',
    `data_quality_flag` STRING COMMENT 'Quality assurance flag indicating the reliability of this forecast record. Values include valid (passed all checks), suspect (anomaly detected), missing (data gap), interpolated (filled from adjacent data), estimated (model-derived).. Valid values are `valid|suspect|missing|interpolated|estimated`',
    `dew_point_c` DECIMAL(18,2) COMMENT 'Forecasted dew point temperature in degrees Celsius. Used to calculate humidity and assess cooling load and comfort index impacts on energy demand.',
    `ensemble_member_number` STRING COMMENT 'Identifier for the ensemble member or scenario within an ensemble forecast system (e.g., ECMWF EPS member 1, 2, 3). Null for deterministic forecasts. Enables probabilistic forecasting and uncertainty quantification.',
    `forecast_confidence_score` DECIMAL(18,2) COMMENT 'Numerical confidence or quality score assigned to this forecast record by the NWP provider or internal validation process. Higher scores indicate greater reliability. Used to weight ensemble forecasts.',
    `forecast_issue_timestamp` TIMESTAMP COMMENT 'The date and time when the NWP model run was issued or published by the provider. This is the model initialization time, critical for tracking forecast vintage and lead time.',
    `forecast_lead_time_hours` STRING COMMENT 'The number of hours between the forecast issue time and the valid time. Indicates forecast horizon and is a key driver of forecast accuracy degradation.',
    `forecast_type` STRING COMMENT 'Classification of the forecast methodology: deterministic (single outcome), ensemble (multiple scenarios), probabilistic (distribution-based), or nowcast (very short-term, 0-6 hours).. Valid values are `deterministic|ensemble|probabilistic|nowcast`',
    `forecast_update_cycle` STRING COMMENT 'The NWP model run cycle identifier (e.g., 00Z, 06Z, 12Z, 18Z for GFS). Indicates which daily model run produced this forecast, critical for tracking model version and update frequency.',
    `forecast_valid_timestamp` TIMESTAMP COMMENT 'The date and time for which this forecast is valid. Represents the target hour or interval that the weather variables predict. Used to align weather inputs with load and generation forecast horizons.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'The date and time when this weather forecast record was ingested into the lakehouse from the external NWP provider or data feed. Used for data lineage and latency tracking.',
    `is_historical_reforecast` BOOLEAN COMMENT 'Boolean flag indicating whether this record is a historical reforecast (hindcast) used for model training and validation, rather than a real-time operational forecast.',
    `notes` STRING COMMENT 'Free-text field for additional context, anomalies, or special conditions associated with this forecast record (e.g., model outage, data correction, extreme weather event).',
    `nwp_model_source` STRING COMMENT 'The numerical weather prediction model provider or system that generated this forecast data (e.g., GFS, ECMWF, NAM, HRRR, WRF). Critical for model performance tracking and ensemble forecasting.. Valid values are `GFS|ECMWF|NAM|HRRR|WRF|CUSTOM`',
    `precipitation_mm` DECIMAL(18,2) COMMENT 'Forecasted precipitation accumulation in millimeters for the forecast interval. Impacts hydro generation availability, solar output, and load patterns during storm events.',
    `precipitation_probability_percent` DECIMAL(18,2) COMMENT 'Forecasted probability of precipitation occurrence as a percentage (0-100). Used in probabilistic forecasting and risk assessment for renewable generation and load variability.',
    `relative_humidity_percent` DECIMAL(18,2) COMMENT 'Forecasted relative humidity as a percentage (0-100). Influences cooling load, HVAC efficiency, and customer comfort-driven energy consumption.',
    `snow_depth_cm` DECIMAL(18,2) COMMENT 'Forecasted snow depth on the ground in centimeters. Relevant for winter peak load forecasting, transmission line loading, and hydro reservoir inflow modeling.',
    `solar_irradiance_w_per_m2` DECIMAL(18,2) COMMENT 'Forecasted global horizontal irradiance (GHI) in watts per square meter. Direct input to solar photovoltaic generation forecasting models and renewable energy integration planning.',
    `source_file_name` STRING COMMENT 'The name of the source file or data feed from which this forecast record was extracted (e.g., GRIB2 file name, API endpoint). Supports data lineage and troubleshooting.',
    `spatial_resolution_km` DECIMAL(18,2) COMMENT 'The spatial grid resolution of the NWP model in kilometers (e.g., GFS 13km, ECMWF 9km). Indicates the granularity of the forecast and impacts accuracy for localized weather phenomena.',
    `temperature_c` DECIMAL(18,2) COMMENT 'Forecasted air temperature in degrees Celsius at the zone or station level. Primary driver of heating and cooling load in energy demand forecasting.',
    `temporal_resolution_minutes` STRING COMMENT 'The time interval between consecutive forecast data points in minutes (e.g., 60 for hourly, 15 for sub-hourly). Defines the granularity of the forecast time series.',
    `visibility_km` DECIMAL(18,2) COMMENT 'Forecasted horizontal visibility in kilometers. May be used in operational safety assessments and can correlate with fog-related load patterns.',
    `weather_station_code` BIGINT COMMENT 'Identifier for the weather station or observation point from which this forecast data is sourced or interpolated.',
    `wind_direction_degrees` DECIMAL(18,2) COMMENT 'Forecasted wind direction in degrees (0-360, where 0/360 is North, 90 is East, 180 is South, 270 is West). Used in wind farm output modeling and turbine-level generation forecasting.',
    `wind_gust_speed_mps` DECIMAL(18,2) COMMENT 'Forecasted maximum wind gust speed in meters per second. Important for wind turbine curtailment decisions and grid stability planning during high-wind events.',
    `wind_speed_mps` DECIMAL(18,2) COMMENT 'Forecasted wind speed in meters per second at the zone or station level. Critical input for wind generation forecasting and renewable intermittency prediction.',
    CONSTRAINT pk_weather_input PRIMARY KEY(`weather_input_id`)
) COMMENT 'Weather forecast data ingested from NWP providers (GFS, ECMWF, NAM) as primary inputs to load, generation, and renewable forecasting models. Stores temperature, humidity, wind speed/direction, cloud cover, precipitation, solar irradiance, and dew point at zone or weather station level. Tracks NWP model source, forecast issue time, and validity period. Critical driver for all forecast accuracy and the primary exogenous variable in energy demand and renewable output prediction.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`model` (
    `model_id` BIGINT COMMENT 'Primary key for model',
    `accuracy_metric_mae` DECIMAL(18,2) COMMENT 'Mean Absolute Error (MAE) of the model on validation data. Measures average forecast error magnitude.',
    `accuracy_metric_mape` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error (MAPE) of the model on validation data. Primary accuracy metric for forecast quality assessment.',
    `accuracy_metric_rmse` DECIMAL(18,2) COMMENT 'Root Mean Squared Error (RMSE) of the model on validation data. Measures forecast deviation in absolute units (MW, MWh, etc.).',
    `approval_date` DATE COMMENT 'Date when the model was formally approved for production use by the model governance committee or designated authority.',
    `calibration_date` DATE COMMENT 'Date when the model was last calibrated or re-trained with updated historical data. Critical for model performance tracking and refresh scheduling.',
    `champion_challenger_flag` BOOLEAN COMMENT 'Indicates whether this model is part of a champion/challenger evaluation workflow. True if the model is being compared against an incumbent champion model.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created in the registry. Used for audit trail and model lifecycle tracking.',
    `deployment_environment` STRING COMMENT 'Environment where the model is currently deployed: development, staging, production, or sandbox. Used for change management and release control.. Valid values are `development|staging|production|sandbox`',
    `documentation_url` STRING COMMENT 'URL or file path to detailed model documentation including methodology, assumptions, validation results, and usage guidelines.',
    `execution_frequency` STRING COMMENT 'Scheduled frequency at which the model generates forecasts: real-time, hourly, daily, weekly, monthly, or on-demand.. Valid values are `real_time|hourly|daily|weekly|monthly|on_demand`',
    `forecast_category` STRING COMMENT 'Primary category of forecast output produced by this model: load forecasting, generation forecasting, renewable intermittency, demand response, price forecasting, or capacity planning.. Valid values are `load|generation|renewable|demand_response|price|capacity`',
    `forecast_horizon` STRING COMMENT 'Temporal scope of the forecast: real-time (minutes), short-term (hours to days), day-ahead, medium-term (weeks to months), seasonal, or long-term (years) for IRP planning.. Valid values are `short_term|medium_term|long_term|real_time|day_ahead|seasonal`',
    `framework` STRING COMMENT 'Software framework or library used to implement the model (e.g., TensorFlow, PyTorch, scikit-learn, R forecast package, proprietary EMS module).',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the forecast model (e.g., service territory, balancing authority area, RTO region, specific substation, or renewable site).',
    `hyperparameters` STRING COMMENT 'JSON or text representation of model hyperparameters (e.g., learning rate, number of layers, regularization coefficients, ensemble weights). Used for model reproducibility and tuning.',
    `input_feature_set` STRING COMMENT 'Comma-separated list or description of input features used by the model (e.g., temperature, humidity, day-of-week, historical load, wind speed, solar irradiance).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was last updated. Tracks configuration changes, recalibration, or metadata updates.',
    `model_code` STRING COMMENT 'Business identifier code for the forecast model used in operational references and reporting. Unique across all registered models.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `model_description` STRING COMMENT 'Detailed textual description of the model purpose, methodology, use cases, and key assumptions. Provides business context for model selection and interpretation.',
    `model_name` STRING COMMENT 'Human-readable name of the forecast model describing its purpose and scope (e.g., Summer Peak Load LSTM, Wind Generation Ensemble).',
    `model_status` STRING COMMENT 'Current lifecycle status of the model: development (under construction), testing (validation phase), champion (production model), challenger (competing alternative), retired, or deprecated.. Valid values are `development|testing|champion|challenger|retired|deprecated`',
    `model_type` STRING COMMENT 'Classification of the forecasting algorithm or methodology used (statistical regression, neural network, ensemble, persistence, ARIMA, LSTM, random forest). [ENUM-REF-CANDIDATE: statistical_regression|neural_network|ensemble|persistence|arima|lstm|random_forest — 7 candidates stripped; promote to reference product]',
    `output_granularity` STRING COMMENT 'Temporal resolution of the forecast output: 5-minute, 15-minute, hourly, daily, monthly, or annual intervals.. Valid values are `5_minute|15_minute|hourly|daily|monthly|annual`',
    `owner_email` STRING COMMENT 'Email address of the model owner for operational communication and governance escalation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Full name of the individual responsible for the model. Primary point of contact for model questions and governance.',
    `owning_team` STRING COMMENT 'Name of the business unit or team responsible for developing, maintaining, and governing this forecast model (e.g., Load Forecasting, Renewable Analytics, Grid Operations).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this model is used for regulatory reporting or compliance purposes (e.g., NERC resource adequacy, FERC market reporting, IRP filings). True if regulatory-critical.',
    `retirement_date` DATE COMMENT 'Date when the model was retired from active use. Null for active models.',
    `training_end_date` DATE COMMENT 'End date of the historical data period used to train the model. Defines the conclusion of the training window.',
    `training_start_date` DATE COMMENT 'Start date of the historical data period used to train the model. Defines the beginning of the training window.',
    `validation_period_end_date` DATE COMMENT 'End date of the out-of-sample validation period used to assess model accuracy.',
    `validation_period_start_date` DATE COMMENT 'Start date of the out-of-sample validation period used to assess model accuracy. Distinct from training period.',
    `version` STRING COMMENT 'Version identifier for the model configuration following semantic versioning (e.g., v1.2.0). Incremented when model structure, hyperparameters, or training data change.. Valid values are `^v?[0-9]+.[0-9]+(.[0-9]+)?$`',
    `weather_data_source` STRING COMMENT 'Name of the weather data provider or service used as input to the model (e.g., NOAA, Weather Underground, proprietary SCADA sensors).',
    CONSTRAINT pk_model PRIMARY KEY(`model_id`)
) COMMENT 'Master entity representing a registered forecasting model configuration used to produce load, generation, or renewable forecasts. Captures model type (statistical regression, neural network, ensemble, persistence), model version, training data period, input feature set, hyperparameters, calibration date, and owning team. Provides model governance and lineage for all forecast runs. Supports model comparison and champion/challenger evaluation workflows.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`accuracy` (
    `accuracy_id` BIGINT COMMENT 'Primary key for accuracy',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: Forecast accuracy records measure the performance of registered forecasting models. The model table is the authoritative registry for model configuration, hyperparameters, and baseline accuracy metric',
    `accuracy_model_id` BIGINT COMMENT 'FK to forecast.model.model_id — Accuracy records measure performance of a specific forecast model. FK enables model performance governance and champion/challenger comparison.',
    `forecast_run_id` BIGINT COMMENT 'Reference to the specific forecast run being evaluated for accuracy. Links to the forecast execution that produced the predictions being measured.',
    `interval_reading_id` BIGINT COMMENT 'Foreign key linking to metering.interval_reading. Business justification: Accuracy records store actual_value_mw used in forecast error calculation; this actual value originates from interval_reading. Linking directly enables model validation workflows, regulatory forecast ',
    `load_forecast_id` BIGINT COMMENT 'Foreign key linking to grid.load_forecast. Business justification: Forecast accuracy records evaluate specific operational load forecasts. Linking accuracy to grid.load_forecast enables EMS-side forecast performance tracking, model benchmarking, and regulatory report',
    `meter_point_id` BIGINT COMMENT 'Foreign key linking to metering.meter_point. Business justification: Forecast accuracy records track performance at specific service points or aggregations. Forecasters identify which meter points drive forecast errors to refine models. Real business process: granular ',
    `meter_read_id` BIGINT COMMENT 'Foreign key linking to metering.meter_read. Business justification: Forecast accuracy evaluation directly compares forecasted values against actual meter reads. Linking accuracy records to the source meter_read enables model validation, regulatory accuracy reporting, ',
    `state_estimation_run_id` BIGINT COMMENT 'Foreign key linking to grid.state_estimation_run. Business justification: Forecast accuracy evaluation uses state estimation results as the source of actuals for load and generation. Linking accuracy records to the state_estimation_run that provided actuals is standard prac',
    `zone_id` BIGINT COMMENT 'Reference to the specific transmission or distribution zone for which accuracy is measured. Null for system-level measurements.',
    `absolute_error_mw` DECIMAL(18,2) COMMENT 'The absolute difference between forecasted and actual values, calculated as |forecasted_value_mw - actual_value_mw|. Used in Mean Absolute Error (MAE) calculations.',
    `actual_value_mw` DECIMAL(18,2) COMMENT 'The actual observed value for the interval, measured in megawatts. This is the realized load, generation, or other metric that occurred and is used as ground truth for accuracy calculation.',
    `benchmark_comparison` STRING COMMENT 'Comparison of the forecast accuracy against a benchmark model or target threshold. Indicates whether the forecast performed better, worse, or equivalent to the benchmark.. Valid values are `better|worse|equivalent`',
    `bias_mw` DECIMAL(18,2) COMMENT 'The signed difference between forecasted and actual values, calculated as forecasted_value_mw - actual_value_mw. Positive bias indicates over-forecasting, negative bias indicates under-forecasting.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the accuracy metric. Provides statistical confidence range for the measured accuracy.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the accuracy metric. Provides statistical confidence range for the measured accuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accuracy record was first created in the system. Used for data lineage and audit trail purposes.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality of the actual data used for accuracy calculation. Flags whether the actual values were validated, suspect, estimated through VEE (Validation Estimation and Editing), or missing.. Valid values are `valid|suspect|estimated|missing`',
    `day_type` STRING COMMENT 'Classification of the day as weekday, weekend, or holiday. Used to segment accuracy analysis by day-of-week patterns that affect load profiles.. Valid values are `weekday|weekend|holiday`',
    `for_run` BIGINT COMMENT 'FK to forecast.run.run_id — Accuracy records are computed for a specific forecast run. FK enables traceability from accuracy metrics to the exact run and input data.',
    `forecast_horizon_hours` STRING COMMENT 'The time horizon of the forecast being evaluated, measured in hours from the forecast issuance time. Common values include 1-hour ahead, 24-hour ahead, 168-hour ahead (weekly), etc.',
    `forecast_type` STRING COMMENT 'The category of forecast being evaluated. Indicates whether this accuracy measurement applies to load forecasting, generation forecasting, renewable intermittency prediction, demand response, price forecasting, or reserve requirements.. Valid values are `load|generation|renewable|demand_response|price|reserve`',
    `forecasted_value_mw` DECIMAL(18,2) COMMENT 'The predicted value from the forecast model, measured in megawatts. This is the value that was forecasted for the interval and is being compared against actuals.',
    `granularity_level` STRING COMMENT 'The geographic or organizational level at which the forecast accuracy is measured. System-level represents total utility territory, zone represents transmission zones, substation and feeder represent distribution levels.. Valid values are `system|zone|substation|feeder|customer_segment|asset`',
    `improvement_opportunity_flag` BOOLEAN COMMENT 'Boolean indicator flagging forecast intervals or conditions where significant accuracy improvement opportunities exist. Used to prioritize model tuning and enhancement efforts.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'The ending timestamp of the forecast interval being evaluated. Represents the end of the period for which the forecast was made and is now being measured against actuals.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'The beginning timestamp of the forecast interval being evaluated. Represents the start of the period for which the forecast was made and is now being measured against actuals.',
    `mae_mw` DECIMAL(18,2) COMMENT 'The Mean Absolute Error for the forecast interval or aggregation period, measured in megawatts. Represents the average magnitude of forecast errors in absolute terms.',
    `mape` DECIMAL(18,2) COMMENT 'The Mean Absolute Percentage Error for the forecast interval or aggregation period. Represents the average magnitude of forecast errors as a percentage of actual values. Industry standard accuracy metric for forecast performance.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The date and time when the forecast accuracy measurement was calculated and recorded. Represents when actuals were compared against forecasted values.',
    `model_version` STRING COMMENT 'The version identifier of the forecasting model that produced the forecast being evaluated. Enables tracking of model performance across versions and model updates.',
    `notes` STRING COMMENT 'Free-text field for capturing contextual information about the accuracy measurement, including explanations for anomalies, data quality issues, or special conditions affecting the forecast.',
    `peak_error_mw` DECIMAL(18,2) COMMENT 'The maximum absolute error observed during the forecast period. Critical for evaluating forecast performance during peak demand or generation periods.',
    `peak_error_timestamp` TIMESTAMP COMMENT 'The timestamp when the peak error occurred. Identifies the specific interval with the largest forecast deviation.',
    `percentage_error` DECIMAL(18,2) COMMENT 'The error expressed as a percentage of the actual value, calculated as ((forecasted_value_mw - actual_value_mw) / actual_value_mw) * 100. Used in Mean Absolute Percentage Error (MAPE) calculations.',
    `regulatory_threshold_met` BOOLEAN COMMENT 'Boolean flag indicating whether the forecast accuracy met regulatory or contractual accuracy thresholds. Used for compliance reporting to FERC, NERC, or RTO/ISO requirements.',
    `rmse_mw` DECIMAL(18,2) COMMENT 'The Root Mean Squared Error for the forecast interval or aggregation period, measured in megawatts. Penalizes larger errors more heavily than MAE and is sensitive to outliers.',
    `sample_size` STRING COMMENT 'The number of individual forecast intervals included in the accuracy calculation. Relevant when accuracy metrics are aggregated across multiple intervals or data points.',
    `season` STRING COMMENT 'The meteorological season during which the forecast interval occurred. Used to track accuracy performance by seasonal patterns and weather regimes.. Valid values are `winter|spring|summer|fall`',
    `squared_error` DECIMAL(18,2) COMMENT 'The square of the difference between forecasted and actual values, calculated as (forecasted_value_mw - actual_value_mw)^2. Used in Root Mean Squared Error (RMSE) calculations.',
    `time_of_day_category` STRING COMMENT 'Classification of the forecast interval by time-of-day load pattern. Used to evaluate accuracy during different daily load shapes and operational conditions.. Valid values are `overnight|morning_ramp|midday|evening_peak|night`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this accuracy record was last modified. Used for tracking changes to accuracy measurements as actuals are revised or data quality improves.',
    `weather_regime` STRING COMMENT 'The weather condition classification during the forecast interval. Used to evaluate forecast accuracy under different weather scenarios that impact load and renewable generation.. Valid values are `normal|extreme_heat|extreme_cold|high_wind|low_wind|storm`',
    CONSTRAINT pk_accuracy PRIMARY KEY(`accuracy_id`)
) COMMENT 'Transactional entity capturing post-hoc forecast accuracy measurements comparing forecasted values against actuals for a completed forecast run. Stores MAPE (Mean Absolute Percentage Error), MAE (Mean Absolute Error), RMSE, bias, and peak error metrics at system, zone, and interval levels. Tracks accuracy by forecast horizon, season, and weather regime. Used for model performance governance, regulatory reporting, and continuous improvement of forecasting processes.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` (
    `irp_scenario_id` BIGINT COMMENT 'Unique identifier for the IRP scenario. Primary key for the irp_scenario product.',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: IRP scenarios model future control area configurations, load growth, generation mix, and transmission expansion. Utilities plan generation and transmission investments within control area operational ',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_permit. Business justification: Long-term resource planning scenarios reference existing environmental permits (air, water, waste) for current facilities and forecast future permit needs for planned generation. IRP modeling includes',
    `load_forecast_id` BIGINT COMMENT 'Foreign key linking to grid.load_forecast. Business justification: IRP scenarios are built on specific load forecast assumptions from operational systems. Tracing IRP scenarios to the grid.load_forecast records that informed load growth assumptions is required for re',
    `parent_scenario_irp_scenario_id` BIGINT COMMENT 'Reference to the parent scenario if this is a sensitivity or variant scenario. Links sensitivity scenarios back to their base case for comparison. Null for base case scenarios.',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to forecast.planning_period. Business justification: irp_scenario has planning_horizon_start_year and planning_horizon_end_year as denormalized integer fields, but no FK to the planning_period master table. IRP scenarios are fundamentally organized arou',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: IRP scenarios are designed to meet specific regulatory obligations (RPS targets, carbon reduction mandates, reliability standards). Each scenario models compliance pathways for a primary obligation, w',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or committee that approved this scenario for inclusion in the IRP filing. Provides accountability and governance trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario was formally approved for inclusion in the IRP filing. Marks transition from draft to official status.',
    `battery_storage_capacity_mw` DECIMAL(18,2) COMMENT 'Total planned battery energy storage system (BESS) capacity additions over the planning horizon for this scenario, measured in megawatts (MW). Critical for renewable integration and grid flexibility.',
    `capacity_market_assumption` STRING COMMENT 'Assumed market structure for capacity procurement. None means vertically integrated utility; energy_only means no separate capacity payments; capacity_market means RTO/ISO capacity auction; hybrid means mixed approach.. Valid values are `none|energy_only|capacity_market|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario record was first created in the system. Audit trail for scenario development lifecycle.',
    `demand_response_credit_mw` DECIMAL(18,2) COMMENT 'Assumed demand response (DR) program capacity credit in megawatts (MW) that can be counted toward resource adequacy. Represents load reduction capability from DR programs during peak periods.',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'Weighted average cost of capital (WACC) or discount rate used for net present value (NPV) calculations in this scenario, expressed as a percentage. Reflects utility cost of capital for investment analysis.',
    `distributed_energy_resource_penetration_pct` DECIMAL(18,2) COMMENT 'Assumed penetration of distributed energy resources (rooftop solar, battery storage, microgrids) as a percentage of total capacity by end of planning horizon. Impacts load forecast and grid planning.',
    `economic_growth_assumption` STRING COMMENT 'Assumed economic growth trajectory for the service territory. Low assumes slow GDP growth; reference uses consensus forecasts; high assumes robust expansion; recession models economic downturn impacts on load.. Valid values are `low|reference|high|recession`',
    `electrification_assumption` STRING COMMENT 'Assumed rate of transportation and building electrification (electric vehicles, heat pumps) over the planning horizon. Low assumes slow adoption; reference uses market forecasts; high assumes policy-driven acceleration.. Valid values are `low|reference|high`',
    `energy_efficiency_savings_gwh` DECIMAL(18,2) COMMENT 'Cumulative annual energy savings from energy efficiency programs by the end of the planning horizon, measured in gigawatt-hours (GWh). Reduces forecasted energy requirements.',
    `filed_timestamp` TIMESTAMP COMMENT 'Timestamp when the IRP containing this scenario was filed with the state Public Utility Commission (PUC). Establishes regulatory record date.',
    `fossil_capacity_retirement_mw` DECIMAL(18,2) COMMENT 'Total planned fossil fuel generation capacity retirements (coal, natural gas, oil) over the planning horizon for this scenario, measured in megawatts (MW). Reflects decarbonization strategy and asset lifecycle management.',
    `load_growth_assumption_pct` DECIMAL(18,2) COMMENT 'Average annual load growth rate assumption for this scenario expressed as a percentage (e.g., 1.50 for 1.5% annual growth). Key driver for capacity planning and resource adequacy analysis.',
    `modeling_software` STRING COMMENT 'Name and version of the capacity expansion or production cost modeling software used to develop this scenario (e.g., PLEXOS, Aurora, PROMOD, Encompass). Important for model transparency and reproducibility.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scenario record was last modified. Tracks iterative refinement during IRP development process.',
    `natural_gas_price_trajectory` STRING COMMENT 'Assumed natural gas price path over the planning horizon. Low assumes sustained low prices; reference uses EIA or market consensus; high assumes supply constraints or carbon pricing; volatile models price uncertainty.. Valid values are `low|reference|high|volatile`',
    `peak_demand_growth_assumption_pct` DECIMAL(18,2) COMMENT 'Average annual peak demand (MW) growth rate assumption for this scenario expressed as a percentage. May differ from energy growth due to load shape changes, electrification, or demand response programs.',
    `planning_horizon_end_year` STRING COMMENT 'Final year of the planning horizon covered by this scenario (typically 10-20 years from start). Four-digit year (e.g., 2043).',
    `planning_horizon_start_year` STRING COMMENT 'First year of the planning horizon covered by this scenario (typically current year or next year). Four-digit year (e.g., 2024).',
    `puc_docket_number` STRING COMMENT 'State PUC docket or case number assigned to the IRP filing containing this scenario. Links scenario to regulatory proceeding for tracking and reference.',
    `reliability_metric_lole` DECIMAL(18,2) COMMENT 'Loss of Load Expectation (LOLE) reliability metric for this scenario, typically measured in days per year. Industry standard is 0.1 days/year (one day in ten years). Demonstrates resource adequacy.',
    `renewable_capacity_addition_mw` DECIMAL(18,2) COMMENT 'Total planned renewable generation capacity additions (solar, wind, hydro, biomass) over the planning horizon for this scenario, measured in megawatts (MW). Key metric for tracking renewable energy integration.',
    `reserve_margin_target_pct` DECIMAL(18,2) COMMENT 'Planning reserve margin target for resource adequacy expressed as a percentage above forecasted peak demand (e.g., 15.00 for 15% reserve margin). Ensures sufficient capacity to meet reliability standards.',
    `retirement_schedule_assumption` STRING COMMENT 'Assumed retirement schedule for existing generation assets. Baseline follows planned retirements; accelerated models early coal/gas plant closures; delayed extends asset life; policy_driven reflects regulatory mandates.. Valid values are `baseline|accelerated|delayed|policy_driven`',
    `scenario_code` STRING COMMENT 'Business identifier code for the scenario (e.g., BASE_2024, HIGH_GROWTH_2024, LOW_CARBON_2024). Used in regulatory filings and internal planning documents.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `scenario_description` STRING COMMENT 'Detailed narrative description of the scenario including key assumptions, strategic rationale, and how it differs from other scenarios in the IRP. Used in regulatory filings and stakeholder presentations.',
    `scenario_name` STRING COMMENT 'Descriptive name of the IRP scenario (e.g., Base Case, High Load Growth, Accelerated Decarbonization, Low Gas Price). Human-readable label for reports and presentations.',
    `scenario_notes` STRING COMMENT 'Additional notes, caveats, or technical details about the scenario that do not fit in other structured fields. Used for model documentation and knowledge transfer.',
    `scenario_status` STRING COMMENT 'Current lifecycle status of the scenario. Draft indicates work in progress; under_review means internal stakeholder review; approved means executive sign-off; filed means submitted to PUC; archived means superseded by newer IRP.. Valid values are `draft|under_review|approved|filed|archived`',
    `scenario_type` STRING COMMENT 'Classification of the scenario within the IRP framework. Base represents the most likely case; sensitivity tests single variable changes; alternative explores different strategic paths; stress_test examines extreme conditions; bookend defines planning boundaries.. Valid values are `base|sensitivity|alternative|stress_test|bookend`',
    `sensitivity_variable` STRING COMMENT 'For sensitivity scenarios, identifies the specific variable being tested (e.g., natural gas price, load growth, carbon price, technology cost). Null for base case scenarios.',
    `stakeholder_feedback_summary` STRING COMMENT 'Summary of stakeholder comments and feedback received on this scenario during public comment periods or technical conferences. Documents stakeholder engagement process required by many state PUCs.',
    `technology_cost_assumption` STRING COMMENT 'Assumed capital cost trajectory for new generation technologies (solar, wind, battery storage, gas turbines). Low assumes rapid cost declines; reference uses industry consensus; high assumes slower learning curves.. Valid values are `low|reference|high`',
    `total_co2_emissions_million_tons` DECIMAL(18,2) COMMENT 'Cumulative CO2 emissions over the planning horizon for this scenario, measured in million metric tons. Key environmental metric for comparing scenarios and demonstrating compliance with carbon reduction goals.',
    `total_resource_cost_npv_million` DECIMAL(18,2) COMMENT 'Net present value of total resource costs (capital, fixed O&M, variable O&M, fuel) over the planning horizon for this scenario, in millions of dollars. Key metric for comparing scenario economics.',
    `transmission_expansion_assumption` STRING COMMENT 'Assumed level of transmission system expansion over the planning horizon. None means no new transmission; limited means targeted upgrades; moderate means regional expansion; aggressive means major interstate projects.. Valid values are `none|limited|moderate|aggressive`',
    `weather_normalization_method` STRING COMMENT 'Method used to normalize weather impacts in load forecasting. Historical_average uses 10-30 year average; climate_adjusted incorporates climate change projections; extreme_weather models increased frequency of heat waves and cold snaps.. Valid values are `historical_average|climate_adjusted|extreme_weather`',
    CONSTRAINT pk_irp_scenario PRIMARY KEY(`irp_scenario_id`)
) COMMENT 'Master record for an Integrated Resource Plan scenario and its year-by-year planning data used in long-term capacity planning and resource adequacy analysis. Captures scenario parameters (load growth, fuel price trajectory, carbon policy, renewable targets, DR credits, retirement schedule) at the header level. Stores annual planning data for each year within the scenario including forecasted peak demand (MW), annual energy requirement (GWh), planned capacity additions/retirements (MW by resource type), reserve margin (%), renewable percentage, and CO2 emissions projection. Multiple scenarios per IRP filing (base, high growth, low carbon). Enables year-by-year resource adequacy gap analysis and investment planning. Submitted to state PUC as part of regulatory IRP process.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` (
    `capacity_requirement_id` BIGINT COMMENT 'Unique identifier for the capacity requirement record. Primary key for the capacity requirement entity.',
    `path_id` BIGINT COMMENT 'Foreign key linking to transmission.path. Business justification: Capacity requirements include transmission_constraint_adjustment_mw driven by specific binding transmission paths. Resource adequacy and IRP filings require identifying which transmission path constra',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: Capacity requirements are calculated per control area for resource adequacy, planning reserve margin compliance, and NERC reliability standards. Control area operators use capacity requirements to ens',
    `planning_period_id` BIGINT COMMENT 'Reference to the planning period for which this capacity requirement applies (e.g., annual IRP cycle, multi-year planning horizon).',
    `irp_scenario_id` BIGINT COMMENT 'FK to forecast.irp_scenario.irp_scenario_id — Capacity requirements are derived from IRP scenarios. FK enables traceability from capacity obligations back to planning assumptions.',
    `zone_id` BIGINT COMMENT 'Reference to the RTO or ISO zone for which this capacity requirement is defined (e.g., PJM, MISO, CAISO, ERCOT, NYISO, ISO-NE).',
    `approval_date` DATE COMMENT 'Date when this capacity requirement was formally approved by the regulatory authority (PUC, FERC) or RTO/ISO governing body.',
    `approved_by` STRING COMMENT 'Name of the regulatory authority, commission, or governing body that approved this capacity requirement (e.g., FERC, California PUC, PJM Board).',
    `capacity_auction_clearing_price_per_mw_day` DECIMAL(18,2) COMMENT 'Market clearing price from the most recent capacity auction in dollars per megawatt-day ($/MW-day). Used for capacity procurement cost forecasting and budget planning.',
    `capacity_deficiency_mw` DECIMAL(18,2) COMMENT 'Calculated capacity deficiency in megawatts (MW), representing the shortfall between the capacity requirement and available capacity. Positive values indicate a need for additional procurement.',
    `capacity_export_limit_mw` DECIMAL(18,2) COMMENT 'Maximum capacity in megawatts (MW) that can be exported to external zones or regions, representing surplus capacity available for sale in external markets.',
    `capacity_import_limit_mw` DECIMAL(18,2) COMMENT 'Maximum capacity in megawatts (MW) that can be imported from external zones or regions to meet the local capacity requirement, based on transmission interface limits.',
    `capacity_surplus_mw` DECIMAL(18,2) COMMENT 'Calculated capacity surplus in megawatts (MW), representing the excess capacity above the requirement. Positive values indicate over-procurement or reserve margin cushion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity requirement record was first created in the system.',
    `deficiency_penalty_rate_per_mw_day` DECIMAL(18,2) COMMENT 'Penalty rate assessed for capacity deficiency in dollars per megawatt-day ($/MW-day). Applied when a load-serving entity fails to meet its capacity obligation.',
    `demand_response_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Capacity requirement allocated to demand response programs in megawatts (MW), representing load reduction capability that can be dispatched during peak periods.',
    `effective_date` DATE COMMENT 'Date when this capacity requirement becomes effective and binding for planning and procurement activities.',
    `energy_storage_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Capacity requirement allocated to energy storage resources (battery, pumped hydro, compressed air) in megawatts (MW). Supports grid flexibility and renewable integration.',
    `expected_unserved_energy_mwh` DECIMAL(18,2) COMMENT 'Expected unserved energy limit in megawatt-hours (MWh), representing the maximum acceptable amount of load that may not be served due to capacity shortfalls. NERC reliability metric.',
    `expiration_date` DATE COMMENT 'Date when this capacity requirement expires or is superseded by a subsequent requirement. Null for open-ended requirements.',
    `filing_reference_number` STRING COMMENT 'Regulatory filing reference number or docket number associated with the approval of this capacity requirement (e.g., FERC docket number, PUC case number).',
    `flexible_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Capacity requirement in megawatts (MW) for flexible ramping resources capable of responding to rapid load changes and renewable intermittency. Supports grid flexibility needs.',
    `forecast_confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level for the peak demand forecast expressed as a percentage (e.g., 90.0% confidence interval). Indicates the reliability of the forecast used to set the capacity requirement.',
    `installed_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Total installed capacity requirement in megawatts (MW) calculated as peak demand plus planning reserve margin. This is the target capacity that must be procured or available.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity requirement record was last modified or updated.',
    `local_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Capacity requirement in megawatts (MW) that must be met by resources located within a specific local reliability area or load pocket, due to transmission constraints.',
    `loss_of_load_probability_target` DECIMAL(18,2) COMMENT 'Target loss of load probability expressed as a decimal (e.g., 0.1 represents one day in ten years). NERC reliability standard threshold for acceptable risk of load shedding.',
    `net_qualifying_capacity_mw` DECIMAL(18,2) COMMENT 'Net qualifying capacity in megawatts (MW) representing the effective capacity contribution of resources after applying derating factors for availability, intermittency, and transmission constraints.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, assumptions, or special considerations for this capacity requirement (e.g., policy drivers, market conditions, planning assumptions).',
    `planning_reserve_margin_percent` DECIMAL(18,2) COMMENT 'Planning reserve margin expressed as a percentage above peak demand, representing the target capacity cushion to ensure reliability (e.g., 15.0% means capacity must be 115% of peak demand).',
    `renewable_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Capacity requirement allocated to renewable energy resources (wind, solar, hydro, biomass) in megawatts (MW). Driven by Renewable Portfolio Standard (RPS) mandates and clean energy targets.',
    `requirement_name` STRING COMMENT 'Business name or label for this capacity requirement (e.g., 2025 Summer Peak Capacity Requirement, PJM RPM 2024/2025).',
    `requirement_status` STRING COMMENT 'Current lifecycle status of the capacity requirement: draft (under development), proposed (submitted for approval), approved (authorized by regulator), active (in effect), superseded (replaced by newer requirement), or archived (historical record).. Valid values are `draft|proposed|approved|active|superseded|archived`',
    `requirement_type` STRING COMMENT 'Classification of the capacity requirement type: installed capacity (ICAP), planning reserve margin (PRM), net qualifying capacity (NQC), resource adequacy (RA), or reliability must-run (RMR).. Valid values are `installed_capacity|planning_reserve_margin|net_qualifying_capacity|resource_adequacy|reliability_must_run`',
    `thermal_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Capacity requirement allocated to thermal generation resources (coal, natural gas, nuclear) in megawatts (MW). Used for resource mix planning and diversification analysis.',
    `transmission_constraint_adjustment_mw` DECIMAL(18,2) COMMENT 'Capacity adjustment in megawatts (MW) to account for transmission system constraints that limit the deliverability of generation capacity to load centers.',
    `unforced_capacity_requirement_mw` DECIMAL(18,2) COMMENT 'Unforced capacity requirement in megawatts (MW), representing capacity adjusted for expected forced outage rates. Used in PJM and other markets to account for resource reliability.',
    `weather_normalization_applied_flag` BOOLEAN COMMENT 'Boolean flag indicating whether weather normalization adjustments were applied to the peak demand forecast (True) or not (False). Weather normalization removes extreme weather variability.',
    CONSTRAINT pk_capacity_requirement PRIMARY KEY(`capacity_requirement_id`)
) COMMENT 'Master entity defining resource adequacy capacity requirements and reliability targets for a planning period. Captures installed capacity reserve margin targets, planning reserve margin (PRM), net qualifying capacity (NQC) by resource type, and RTO/ISO-mandated capacity obligations (e.g., PJM RPM, MISO PRA). Stores NERC reliability standard thresholds including loss-of-load probability (LOLP) targets and expected unserved energy (EUE) limits. Drives capacity procurement triggers, deficiency penalties, and IRP resource selection. Updated annually per RTO/ISO capacity auction results.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`energy_price` (
    `energy_price_id` BIGINT COMMENT 'Primary key for energy_price',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to grid.control_area. Business justification: LMP forecasts are control-area-specific for market operations, interchange pricing, and economic dispatch optimization. Control area boundaries define pricing zones and congestion management regions i',
    `model_id` BIGINT COMMENT 'Foreign key linking to forecast.model. Business justification: Energy price forecasts are produced by registered forecasting models. The model table is the authoritative registry for model configuration and performance metrics. Adding forecast_model_id FK allows ',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.run. Business justification: energy_price is the master record for energy price forecasts; energy_price_forecast_interval contains interval-level detail. Linking to run establishes the execution context. The run table captures ru',
    `planning_period_id` BIGINT COMMENT 'Foreign key linking to forecast.planning_period. Business justification: energy_price is used in IRP economic analysis and forward price forecasting, which are organized around planning periods. energy_price has forecast_effective_start_date and forecast_effective_end_date',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Energy price forecasts (LMPs) are calculated at specific pnodes. Every LMP forecast is inherently tied to a pnode location. RTO/ISO market settlement, FTR valuation, and congestion analysis all requir',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Energy price forecasts are spatially scoped to pricing nodes, which are located within forecast zones. The zone table defines geographic boundaries and RTO/ISO zone mappings. Adding forecast_zone_id F',
    `superseded_by_forecast_energy_price_id` BIGINT COMMENT 'Reference to the newer forecast that supersedes this one. Nullable if this is the current active forecast. Supports forecast version lineage.',
    `ancillary_services_price_usd_per_mwh` DECIMAL(18,2) COMMENT 'Forecasted price for ancillary services (regulation, spinning reserves, non-spinning reserves) in US dollars per megawatt-hour. Supports grid stability and frequency control cost modeling.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast was approved by an authorized user. Distinct lifecycle event from creation and modification.',
    `capacity_price_usd_per_mw_day` DECIMAL(18,2) COMMENT 'Forecasted capacity price in US dollars per megawatt-day. Represents the cost of ensuring resource adequacy and grid reliability through capacity markets.',
    `carbon_price_usd_per_ton` DECIMAL(18,2) COMMENT 'Forecasted carbon price or carbon tax in US dollars per ton of CO2 equivalent. Used for environmental compliance cost modeling and Renewable Portfolio Standard (RPS) analysis.',
    `coal_price_usd_per_ton` DECIMAL(18,2) COMMENT 'Forecasted coal price in US dollars per ton. Used for modeling generation costs for coal-fired power plants.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this forecast (e.g., USD, CAD, EUR). Supports multi-currency operations for international utilities.. Valid values are `^[A-Z]{3}$`',
    `forecast_confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level of the forecast expressed as a percentage (e.g., 80%, 90%, 95%). Indicates the probability that actual prices will fall within the forecasted range.',
    `forecast_effective_end_date` DATE COMMENT 'The last date for which this forecast is applicable. Defines the end of the forecast validity period. Nullable for open-ended forecasts.',
    `forecast_effective_start_date` DATE COMMENT 'The first date for which this forecast is applicable. Defines the beginning of the forecast validity period.',
    `forecast_identifier` STRING COMMENT 'Business-readable identifier or code for this forecast run, used for tracking and referencing in reports and analysis.',
    `forecast_interval_end_timestamp` TIMESTAMP COMMENT 'The precise end timestamp of the interval for which this price forecast applies. Defines the interval boundary for time-series price data.',
    `forecast_interval_start_timestamp` TIMESTAMP COMMENT 'The precise start timestamp of the interval for which this price forecast applies. Used for interval-level LMP forecasting at hourly or sub-hourly resolution.',
    `forecast_methodology` STRING COMMENT 'The methodology used to generate this forecast: fundamental (supply-demand modeling), statistical (time-series analysis), machine learning (AI/ML models), hybrid (combination), or expert judgment (analyst-driven).. Valid values are `fundamental|statistical|machine_learning|hybrid|expert_judgment`',
    `forecast_notes` STRING COMMENT 'Free-text notes or commentary from analysts regarding assumptions, limitations, or special considerations for this forecast. Supports transparency and decision-making context.',
    `forecast_scenario_code` BIGINT COMMENT 'Reference to the forecast scenario under which this price forecast was generated (e.g., base case, high load, low fuel cost).',
    `forecast_source_system` STRING COMMENT 'Name or identifier of the source system that generated this forecast (e.g., OpenLink Endur, proprietary forecasting tool, third-party vendor). Supports data lineage and audit.',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the forecast: draft (under development), approved (validated by analysts), published (released for operational use), superseded (replaced by newer forecast), or archived (historical record).. Valid values are `draft|approved|published|superseded|archived`',
    `forecast_type` STRING COMMENT 'Classification of the forecast horizon: short-term (hours to days), mid-term (weeks to months), long-term (years), day-ahead market (DAM), real-time market (RTM), or seasonal planning.. Valid values are `short_term|mid_term|long_term|day_ahead|real_time|seasonal`',
    `hedging_strategy_flag` BOOLEAN COMMENT 'Indicates whether this forecast is used for developing hedging strategies and risk management in energy trading. True if used for hedging, False otherwise.',
    `interval_duration_minutes` STRING COMMENT 'The duration of the forecast interval in minutes (e.g., 5, 15, 60). Supports configurable resolution for different market and planning needs.',
    `iso_rto_code` STRING COMMENT 'Code identifying the ISO or RTO market region for this forecast (e.g., CAISO, PJM, ERCOT, MISO, NYISO, ISO-NE, SPP). Critical for market-specific price modeling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last updated or modified. Supports change tracking and audit requirements.',
    `lcoe_calculation_flag` BOOLEAN COMMENT 'Indicates whether this forecast is used for LCOE calculations and generation asset economic analysis. True if used for LCOE, False otherwise.',
    `lmp_congestion_component_usd_per_mwh` DECIMAL(18,2) COMMENT 'Forecasted congestion component of the LMP in US dollars per megawatt-hour. Reflects transmission constraints and grid congestion costs at this pricing node.',
    `lmp_energy_component_usd_per_mwh` DECIMAL(18,2) COMMENT 'Forecasted energy component of the Locational Marginal Price in US dollars per megawatt-hour. Represents the marginal cost of serving the next increment of load at this location.',
    `lmp_loss_component_usd_per_mwh` DECIMAL(18,2) COMMENT 'Forecasted loss component of the LMP in US dollars per megawatt-hour. Accounts for electrical losses in transmission from generation to load.',
    `lmp_total_usd_per_mwh` DECIMAL(18,2) COMMENT 'Total forecasted Locational Marginal Price in US dollars per megawatt-hour. Sum of energy, congestion, and loss components. Primary price metric for market operations and economic dispatch.',
    `market_type` STRING COMMENT 'The type of energy market this forecast applies to: day-ahead market (DAM), real-time market (RTM), bilateral contract, or forward market.. Valid values are `day_ahead|real_time|bilateral|forward`',
    `natural_gas_price_usd_per_mmbtu` DECIMAL(18,2) COMMENT 'Forecasted forward natural gas price in US dollars per million British thermal units. Critical input for generation cost modeling and LCOE calculations for gas-fired plants.',
    `ppa_valuation_flag` BOOLEAN COMMENT 'Indicates whether this forecast is specifically used for PPA economic valuation and contract negotiation. True if used for PPA analysis, False otherwise.',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast was published and made available for operational decision-making, trading strategy, and planning activities.',
    `renewable_energy_credit_price_usd` DECIMAL(18,2) COMMENT 'Forecasted price for Renewable Energy Certificates in US dollars per certificate. Used for RPS compliance cost modeling and renewable energy valuation.',
    `renewable_generation_forecast_mw` DECIMAL(18,2) COMMENT 'Forecasted renewable generation (wind, solar, hydro) in megawatts. Accounts for renewable intermittency and its impact on market prices.',
    `transmission_constraint_flag` BOOLEAN COMMENT 'Indicates whether transmission constraints are expected to be binding during this forecast interval. True if constraints are active, False otherwise. Impacts congestion component of LMP.',
    `weather_scenario` STRING COMMENT 'The weather scenario assumption underlying this price forecast: normal (historical average), hot, cold, extreme heat, extreme cold, or mild. Weather is a key driver of load and renewable generation.. Valid values are `normal|hot|cold|extreme_heat|extreme_cold|mild`',
    CONSTRAINT pk_energy_price PRIMARY KEY(`energy_price_id`)
) COMMENT 'Master record and interval-level values for forward energy price forecasts used in IRP economic analysis, PPA valuation, and trading strategy. Stores forecasted LMP by pricing node at the header level with fuel price trajectories, carbon price assumptions, and capacity price forecasts. Includes interval-level LMP ($/MWh) by PNode with energy, congestion, and loss components, forward natural gas price ($/MMBtu), and capacity price ($/MW-day) at configurable resolution. Supports LCOE calculations, economic dispatch optimization, hedging strategy development, bilateral contract valuation, and market participation decisions.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`zone` (
    `zone_id` BIGINT COMMENT 'Primary key for zone',
    `parent_zone_id` BIGINT COMMENT 'Reference to the parent zone in a hierarchical zone structure. Enables roll-up aggregation from distribution feeder zones to load zones to transmission zones to RTO/ISO market zones.',
    `area_square_km` DECIMAL(18,2) COMMENT 'Total geographic area of the forecast zone in square kilometers. Used for density calculations, load intensity analysis, and spatial planning.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the zones geographic centroid in decimal degrees. Used for distance calculations, weather station proximity analysis, and map display.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the zones geographic centroid in decimal degrees. Used for distance calculations, weather station proximity analysis, and map display.',
    `climate_zone` STRING COMMENT 'Climate classification for this zone based on Köppen climate classification or regional climate zones. Used for weather normalization and temperature sensitivity modeling. Examples: Humid Subtropical, Mediterranean, Continental.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone record was first created in the system. Used for audit trail and data lineage.',
    `customer_count` STRING COMMENT 'Total number of customer accounts or service points within this forecast zone. Used for per-capita load analysis and customer density metrics.',
    `der_penetration_percent` DECIMAL(18,2) COMMENT 'Percentage of total load served by Distributed Energy Resources (behind-the-meter solar, battery storage, microgrids) within this zone. Used for DER impact forecasting and grid planning.',
    `effective_date` DATE COMMENT 'Date when this zone definition became effective for operational use. Used for temporal zone boundary changes and historical forecast reconciliation.',
    `expiration_date` DATE COMMENT 'Date when this zone definition expires or was retired. Null for currently active zones. Used for zone lifecycle management and historical analysis.',
    `feeder_count` STRING COMMENT 'Number of distribution feeders that comprise or are contained within this forecast zone. Relevant for distribution feeder zones and load zones.',
    `forecast_accuracy_mape` DECIMAL(18,2) COMMENT 'Historical forecast accuracy for this zone measured as Mean Absolute Percentage Error. Lower values indicate better forecast performance. Used for zone-level accuracy tracking and model tuning.',
    `forecast_model_version` STRING COMMENT 'Version identifier of the forecast model or algorithm currently applied to this zone. Used for model performance tracking and version control in forecast accuracy analysis.',
    `geographic_boundary_wkt` STRING COMMENT 'Well-Known Text representation of the zones geographic boundary polygon or multipolygon. Used for spatial queries, GIS integration, and zone overlap analysis. Conforms to OGC Simple Features specification.',
    `installed_generation_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed generation capacity within this zone in megawatts. Includes conventional and renewable generation. Used for generation adequacy and renewable penetration analysis.',
    `modified_by` STRING COMMENT 'User or system identifier that last modified this zone record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the zone definition, boundary changes, special characteristics, or operational considerations.',
    `peak_load_mw` DECIMAL(18,2) COMMENT 'Historical or design peak load for this zone in megawatts. Used as a reference point for forecast accuracy tracking and capacity adequacy assessment.',
    `primary_weather_station_code` STRING COMMENT 'Identifier of the primary weather station used for weather data correlation and temperature-sensitive load forecasting for this zone. Typically a NOAA station identifier or internal weather station code.',
    `renewable_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed renewable generation capacity within this zone in megawatts. Includes solar, wind, hydro, and other renewable sources. Used for Renewable Portfolio Standard (RPS) tracking and intermittency forecasting.',
    `rto_iso_name` STRING COMMENT 'Name of the RTO or ISO that governs this zone. Examples: PJM, CAISO, ERCOT, MISO, ISO-NE, NYISO, SPP. Used for regulatory reporting and market data integration.',
    `rto_iso_zone_code` STRING COMMENT 'External zone code used by the Regional Transmission Organization or Independent System Operator for market operations, pricing, and settlement. Maps internal zones to RTO/ISO market zones for Day-Ahead Market (DAM) and Real-Time Market (RTM) alignment.',
    `substation_count` STRING COMMENT 'Number of substations located within or serving this forecast zone. Used for infrastructure density analysis and capacity planning.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for this zone. Used for timestamp normalization and daylight saving time adjustments in forecast calculations. Examples: America/New_York, America/Chicago, America/Los_Angeles.',
    `voltage_level_kv` STRING COMMENT 'Primary voltage level(s) associated with this zone. For transmission zones, this is the transmission voltage (e.g., 345, 500). For distribution zones, this is the distribution voltage (e.g., 12.47, 34.5). Multiple levels may be comma-separated.',
    `zone_code` STRING COMMENT 'Business identifier code for the forecast zone, used across operational systems and market reporting. Typically aligns with RTO/ISO zone naming conventions or internal geographic identifiers.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `zone_name` STRING COMMENT 'Human-readable name of the forecast zone, used for reporting and display purposes. Examples: Metro East Load Zone, Coastal Weather Zone, Northern Transmission Zone.',
    `zone_status` STRING COMMENT 'Current lifecycle status of the forecast zone. Active zones are in operational use, inactive zones are temporarily suspended, retired zones are no longer used, and planned zones are defined for future use.. Valid values are `active|inactive|retired|planned`',
    `zone_type` STRING COMMENT 'Classification of the forecast zone by its primary purpose. Load zones aggregate customer demand, weather zones group meteorological data, transmission zones define grid topology, distribution feeder zones represent circuit-level aggregation, market zones align with RTO/ISO pricing nodes, and planning zones support long-term capacity planning.. Valid values are `load_zone|weather_zone|transmission_zone|distribution_feeder_zone|market_zone|planning_zone`',
    `created_by` STRING COMMENT 'User or system identifier that created this zone record. Used for audit trail and data lineage.',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Reference master defining geographic forecast zones used to spatially aggregate all forecast products. Captures zone name, type (load zone, weather zone, transmission zone, distribution feeder zone), geographic boundary, associated substations, and RTO/ISO zone mapping. Provides the spatial hierarchy for load, generation, renewable, and price forecasts. Enables zone-level accuracy tracking, planning aggregation, and alignment with RTO/ISO market zones. Integrates with Esri ArcGIS Utility Network geographic boundaries.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` (
    `forecast_run_id` BIGINT COMMENT 'Unique identifier for the forecast model run execution record. Primary key for the run entity.',
    `baseline_run_id` BIGINT COMMENT 'Reference to a previous forecast run used as the baseline for comparison or delta analysis, supporting forecast accuracy assessment and model improvement.',
    `model_id` BIGINT COMMENT 'Reference to the specific forecast model configuration used for this run, linking to the model registry.',
    `superseded_by_run_forecast_run_id` BIGINT COMMENT 'Reference to a subsequent forecast run that supersedes this run, establishing forecast version lineage and supporting operational decision-making with the most current forecast.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast run output was approved for publication, establishing the approval audit trail.',
    `compute_cluster_code` STRING COMMENT 'Identifier of the computational cluster or resource pool used to execute the forecast run, supporting performance analysis and resource allocation optimization.',
    `configuration_parameters` STRING COMMENT 'JSON or structured text representation of the model configuration parameters and hyperparameters used for this forecast run, enabling full reproducibility and parameter sensitivity analysis.',
    `convergence_iterations` STRING COMMENT 'Number of computational iterations required for the forecast model to reach convergence or the maximum iteration limit, used for performance tuning and model diagnostics.',
    `convergence_status` STRING COMMENT 'Indicator of whether the forecast model achieved mathematical convergence within acceptable tolerance thresholds, critical for assessing forecast reliability and model stability.. Valid values are `converged|not_converged|partial_convergence|timeout`',
    `convergence_tolerance` DECIMAL(18,2) COMMENT 'The mathematical tolerance threshold used to determine model convergence, typically expressed as a percentage or absolute error metric.',
    `cpu_hours_consumed` DECIMAL(18,2) COMMENT 'Total computational resource consumption measured in CPU hours for this forecast run, used for cost allocation and capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast run record was first created in the system, supporting audit trail and data lineage requirements.',
    `duration_seconds` DECIMAL(18,2) COMMENT 'Total elapsed time in seconds for the forecast run execution, calculated from start to end timestamp for performance monitoring and capacity planning.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast model run execution completed or terminated, used to calculate run duration and performance metrics.',
    `error_message` STRING COMMENT 'Detailed error message or exception information captured if the forecast run failed or encountered critical issues, supporting troubleshooting and root cause analysis.',
    `execution_environment` STRING COMMENT 'The computational environment where the forecast run was executed, distinguishing between production forecasts and test or validation runs.. Valid values are `production|staging|development|test|validation`',
    `forecast_end_timestamp` TIMESTAMP COMMENT 'The ending timestamp of the forecast period that this run produces predictions for, defining the last interval of the forecast output.',
    `forecast_horizon_hours` STRING COMMENT 'The time span in hours that this forecast run covers from the forecast start time, defining the look-ahead period for operational planning and dispatch decisions.',
    `forecast_start_timestamp` TIMESTAMP COMMENT 'The beginning timestamp of the forecast period that this run produces predictions for, defining the first interval of the forecast output.',
    `forecast_type` STRING COMMENT 'Classification of the forecast domain this run produces, distinguishing between load forecasting, generation forecasting, renewable intermittency prediction, price forecasting, and demand response forecasting.. Valid values are `load|generation|renewable|price|demand_response`',
    `geographic_scope` STRING COMMENT 'The geographic or electrical network level at which this forecast run operates, defining the spatial granularity of forecast outputs.. Valid values are `system|zone|substation|feeder|service_territory`',
    `input_data_snapshot_code` STRING COMMENT 'Reference identifier to the specific snapshot of input data used for this forecast run, enabling full traceability and reproducibility of forecast results by linking to historical, weather, and operational data versions.. Valid values are `^[A-Z0-9_-]{10,50}$`',
    `interval_resolution_minutes` STRING COMMENT 'The temporal granularity of forecast intervals produced by this run, typically 5, 15, 30, or 60 minutes for operational forecasting aligned with market and dispatch intervals.',
    `memory_peak_gb` DECIMAL(18,2) COMMENT 'Peak memory utilization in gigabytes during forecast run execution, used for resource sizing and performance optimization.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast run record was last modified, tracking updates to status, validation results, or metadata throughout the run lifecycle.',
    `notes` STRING COMMENT 'Free-text notes or comments about the forecast run, capturing operational context, special conditions, or analyst observations relevant to forecast interpretation.',
    `output_record_count` BIGINT COMMENT 'Total number of forecast interval records produced by this run, used for completeness verification and data quality monitoring.',
    `output_validation_status` STRING COMMENT 'Result of automated validation checks applied to forecast output data, including range checks, consistency checks, and business rule validation to ensure forecast quality before publication.. Valid values are `passed|failed|warning|not_validated`',
    `published_flag` BOOLEAN COMMENT 'Indicator of whether this forecast run output has been published for operational use by dispatch, trading, and planning systems.',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast run output was published and made available to downstream operational systems and users.',
    `run_number` STRING COMMENT 'Business-friendly identifier for the forecast run, typically formatted as a human-readable code for operational reference and audit trails.. Valid values are `^[A-Z0-9]{8,20}$`',
    `run_status` STRING COMMENT 'Current lifecycle status of the forecast run execution, tracking progression from initiation through completion or failure states.. Valid values are `pending|running|completed|failed|cancelled|partial`',
    `run_type` STRING COMMENT 'Classification of the forecast run execution trigger mechanism, distinguishing between automated scheduled runs, manual operator-initiated runs, event-driven runs, historical backfills, reforecasts, and validation runs.. Valid values are `scheduled|manual|event_triggered|backfill|reforecast|validation`',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast model run execution began, marking the initiation of the computational process.',
    `to_model` BIGINT COMMENT 'FK to forecast.forecast_model.forecast_model_id — Every forecast run execution must reference the model version used. Core lineage FK for auditability.',
    `triggered_by_event` STRING COMMENT 'Description or identifier of the specific event that triggered this forecast run for event-driven executions, such as significant weather changes, grid events, or market conditions.',
    `validation_error_count` STRING COMMENT 'Total number of validation errors detected in the forecast output, used to assess data quality and determine if manual review or rerun is required.',
    `validation_warning_count` STRING COMMENT 'Total number of validation warnings detected in the forecast output, indicating potential quality issues that do not prevent publication but require attention.',
    `warning_message` STRING COMMENT 'Warning messages or alerts generated during forecast run execution that do not prevent completion but indicate potential quality or performance issues.',
    `weather_data_source` STRING COMMENT 'Identification of the weather data provider or service used as input for this forecast run, such as NOAA, Weather Underground, or proprietary weather services.',
    `weather_scenario` STRING COMMENT 'Classification of the weather conditions or scenario used in the forecast model run, supporting sensitivity analysis and scenario planning for weather-dependent load and renewable generation forecasting. [ENUM-REF-CANDIDATE: actual|normal|hot|cold|extreme_heat|extreme_cold|high_wind|low_wind — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_forecast_run PRIMARY KEY(`forecast_run_id`)
) COMMENT 'Transactional entity capturing the execution record of a forecast model run, including run timestamp, triggering event (scheduled, manual, event-triggered), input data snapshot reference, model version used, run duration, convergence status, and output validation flags. Provides operational lineage and auditability for all forecast outputs. Enables traceability from forecast interval values back to the specific model run and input data used, supporting regulatory and operational audit requirements.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`forecast`.`planning_period` (
    `planning_period_id` BIGINT COMMENT 'Primary key for planning_period',
    `previous_planning_period_id` BIGINT COMMENT 'Self-referencing FK on planning_period (previous_planning_period_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the planning period record was first created in the system.',
    `end_date` DATE COMMENT 'Last calendar date of the planning period.',
    `forecast_horizon_days` STRING COMMENT 'Number of days ahead for which forecasts are generated within this period.',
    `horizon_days` STRING COMMENT 'Total number of days covered by the planning period.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this period is the default selection for new forecasts.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or process that performed the latest update.',
    `notes` STRING COMMENT 'Additional remarks or operational notes attached to the planning period.',
    `period_type` STRING COMMENT 'Category of the planning period indicating its planning horizon or scenario purpose.',
    `planning_cycle_code` STRING COMMENT 'Short code representing the planning cycle (e.g., "FY24", "Q2-2024").',
    `planning_horizon_type` STRING COMMENT 'Indicates whether the horizon follows calendar, fiscal, or operational definitions.',
    `planning_horizon_years` STRING COMMENT 'Number of years spanned by the planning period (useful for long‑term scenarios).',
    `planning_month` STRING COMMENT 'Month number (1‑12) of the planning period.',
    `planning_period_description` STRING COMMENT 'Free‑form text describing the purpose, assumptions, or special notes for the period.',
    `planning_period_name` STRING COMMENT 'Human‑readable name of the planning period (e.g., "2024 Summer Peak").',
    `planning_period_status` STRING COMMENT 'Current lifecycle status of the planning period.',
    `planning_quarter` STRING COMMENT 'Quarter of the year for the planning period.',
    `planning_year` STRING COMMENT 'Fiscal or calendar year to which the planning period belongs.',
    `start_date` DATE COMMENT 'First calendar date of the planning period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the planning period record.',
    `version` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_planning_period PRIMARY KEY(`planning_period_id`)
) COMMENT 'Master reference table for planning_period. Referenced by planning_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_load_model_id` FOREIGN KEY (`load_model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_primary_baseline_forecast_load_id` FOREIGN KEY (`primary_baseline_forecast_load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ADD CONSTRAINT `fk_forecast_generation_forecast_interval_forecast_generation_id` FOREIGN KEY (`forecast_generation_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_generation`(`forecast_generation_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ADD CONSTRAINT `fk_forecast_generation_forecast_interval_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ADD CONSTRAINT `fk_forecast_generation_forecast_interval_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ADD CONSTRAINT `fk_forecast_peak_demand_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ADD CONSTRAINT `fk_forecast_peak_demand_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ADD CONSTRAINT `fk_forecast_peak_demand_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ADD CONSTRAINT `fk_forecast_peak_demand_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ADD CONSTRAINT `fk_forecast_weather_input_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_accuracy_model_id` FOREIGN KEY (`accuracy_model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ADD CONSTRAINT `fk_forecast_irp_scenario_parent_scenario_irp_scenario_id` FOREIGN KEY (`parent_scenario_irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ADD CONSTRAINT `fk_forecast_irp_scenario_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ADD CONSTRAINT `fk_forecast_capacity_requirement_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ADD CONSTRAINT `fk_forecast_capacity_requirement_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ADD CONSTRAINT `fk_forecast_capacity_requirement_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_superseded_by_forecast_energy_price_id` FOREIGN KEY (`superseded_by_forecast_energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ADD CONSTRAINT `fk_forecast_zone_parent_zone_id` FOREIGN KEY (`parent_zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ADD CONSTRAINT `fk_forecast_forecast_run_baseline_run_id` FOREIGN KEY (`baseline_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ADD CONSTRAINT `fk_forecast_forecast_run_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ADD CONSTRAINT `fk_forecast_forecast_run_superseded_by_run_forecast_run_id` FOREIGN KEY (`superseded_by_run_forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`planning_period` ADD CONSTRAINT `fk_forecast_planning_period_previous_planning_period_id` FOREIGN KEY (`previous_planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`forecast` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `energy_utilities_ecm`.`forecast` SET TAGS ('dbx_domain' = 'forecast');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` SET TAGS ('dbx_subdomain' = 'load_planning');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Load Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `primary_baseline_forecast_load_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Forecast ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'p10|p50|p90|p95|deterministic');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `day_type` SET TAGS ('dbx_business_glossary_term' = 'Day Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `day_type` SET TAGS ('dbx_value_regex' = 'weekday|weekend|holiday|special_event');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `demand_response_adjustment_mw` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Adjustment Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `der_penetration_percent` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Penetration Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `economic_scenario` SET TAGS ('dbx_business_glossary_term' = 'Economic Scenario');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `economic_scenario` SET TAGS ('dbx_value_regex' = 'base|high_growth|low_growth|recession|recovery');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `electric_vehicle_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Load Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `energy_efficiency_adjustment_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency (EE) Adjustment Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_accuracy_mape` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_bias_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|published|superseded|archived');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'short_term|day_ahead|week_ahead|seasonal|long_term|irp_scenario');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'system_wide|zone|substation|feeder|service_territory|balancing_authority');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `interval_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Resolution Minutes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `peak_demand_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `peak_demand_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'winter|spring|summer|fall');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `temperature_sensitivity_mw_per_degree` SET TAGS ('dbx_business_glossary_term' = 'Temperature Sensitivity Megawatts (MW) Per Degree');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `total_energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Total Energy Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ALTER COLUMN `weather_scenario` SET TAGS ('dbx_business_glossary_term' = 'Weather Scenario');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` SET TAGS ('dbx_subdomain' = 'load_planning');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `load_forecast_interval_id` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast Interval Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Load Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `actual_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Load in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `baseline_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Baseline Load in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|estimated|missing');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `day_type` SET TAGS ('dbx_business_glossary_term' = 'Day Type Classification');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `day_type` SET TAGS ('dbx_value_regex' = 'weekday|weekend|holiday');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `demand_response_adjustment_mw` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Adjustment in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `der_adjustment_mw` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Adjustment in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `ev_load_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Load Forecast in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_horizon_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon in Hours');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|revised|superseded');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'short_term|day_ahead|week_ahead|month_ahead|seasonal|long_term');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration in Minutes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Forecasting Model Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecasting Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `p10_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'P10 Forecast in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `p90_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'P90 Forecast in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `peak_indicator` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Indicator');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `point_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Point Forecast in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season Classification');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'winter|spring|summer|fall');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `weather_adjusted_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Weather-Adjusted Forecast in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ALTER COLUMN `weather_station_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Station Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` SET TAGS ('dbx_subdomain' = 'generation_output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for forecast_generation');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Asset Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `actual_output_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Generation Output in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature in Celsius');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `dispatch_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Schedule Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forced_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_effective_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_effective_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_run_identifier` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Business Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Lifecycle Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|superseded|cancelled');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecasted_output_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Generation Output in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `forecasted_output_mwh` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Generation Output in Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `fuel_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Availability Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `fuel_availability_status` SET TAGS ('dbx_value_regex' = 'normal|constrained|limited|unavailable|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Fuel Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval Duration in Minutes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `interval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `market_bid_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Bid Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `p10_output_mw` SET TAGS ('dbx_business_glossary_term' = 'P10 Probabilistic Output in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `p50_output_mw` SET TAGS ('dbx_business_glossary_term' = 'P50 Probabilistic Output in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `p90_output_mw` SET TAGS ('dbx_business_glossary_term' = 'P90 Probabilistic Output in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate in Megawatts per Minute (MW/min)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `scheduled_maintenance_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `solar_irradiance_w_per_m2` SET TAGS ('dbx_business_glossary_term' = 'Solar Irradiance in Watts per Square Meter (W/m²)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `technology` SET TAGS ('dbx_business_glossary_term' = 'Generation Technology Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `weather_scenario` SET TAGS ('dbx_business_glossary_term' = 'Weather Scenario Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ALTER COLUMN `wind_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed in Meters per Second (m/s)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` SET TAGS ('dbx_subdomain' = 'generation_output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `generation_forecast_interval_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Forecast Interval ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Unit ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Forecast Run ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `actual_mw_output` SET TAGS ('dbx_business_glossary_term' = 'Actual Megawatt (MW) Output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `agc_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Generation Control (AGC) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `curtailment_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Risk Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|missing|suspect|override');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `dispatch_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Priority Rank');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_error_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_horizon_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Hours');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_mw_output` SET TAGS ('dbx_business_glossary_term' = 'Forecast Megawatt (MW) Output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_mwh_energy` SET TAGS ('dbx_business_glossary_term' = 'Forecast Megawatt-Hour (MWh) Energy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'day_ahead|hour_ahead|real_time|week_ahead|seasonal');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `fuel_consumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Rate');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate British Thermal Unit (BTU) Per Kilowatt-Hour (kWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration Minutes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `must_run_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Run Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `p10_mw_output` SET TAGS ('dbx_business_glossary_term' = 'P10 Megawatt (MW) Output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `p50_mw_output` SET TAGS ('dbx_business_glossary_term' = 'P50 Megawatt (MW) Output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `p90_mw_output` SET TAGS ('dbx_business_glossary_term' = 'P90 Megawatt (MW) Output');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `ramp_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Ramp Constraint Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate Megawatt (MW) Per Minute');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `variance_explanation_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ALTER COLUMN `variance_explanation_code` SET TAGS ('dbx_value_regex' = 'weather_deviation|forced_outage|curtailment|fuel_constraint|transmission_limit|model_error');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` SET TAGS ('dbx_subdomain' = 'renewable_modeling');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_renewable_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for forecast_renewable');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `operating_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Limit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `ppa_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `actual_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Level');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_value_regex' = 'asset|portfolio|zone|balancing_authority|iso_rto');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `capacity_factor_forecast` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Forecast');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `curtailment_mw` SET TAGS ('dbx_business_glossary_term' = 'Curtailment (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `curtailment_probability` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Probability');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_error_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon End');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Start');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|published|superseded|archived');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'day_ahead|hour_ahead|week_ahead|intraday|real_time|seasonal');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_use_case` SET TAGS ('dbx_business_glossary_term' = 'Forecast Use Case');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecast_use_case` SET TAGS ('dbx_value_regex' = 'dispatch|market_bidding|rps_compliance|grid_balancing|capacity_planning|vpp_optimization');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecasted_mw_p10` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Megawatt (MW) P10');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecasted_mw_p50` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Megawatt (MW) P50');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecasted_mw_p90` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Megawatt (MW) P90');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `forecasted_rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `irradiance_w_per_m2` SET TAGS ('dbx_business_glossary_term' = 'Irradiance (W/m²)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `ramp_event_probability` SET TAGS ('dbx_business_glossary_term' = 'Ramp Event Probability');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (MW/min)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `rec_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `technology` SET TAGS ('dbx_business_glossary_term' = 'Renewable Technology');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `technology` SET TAGS ('dbx_value_regex' = 'solar_pv|wind_onshore|wind_offshore|hydro_run_of_river|hybrid');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `transmission_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Transmission Constraint Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ALTER COLUMN `wind_speed_m_per_s` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (m/s)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` SET TAGS ('dbx_subdomain' = 'renewable_modeling');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `renewable_forecast_interval_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Forecast Interval ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_renewable_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Renewable Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `operating_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Limit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Asset ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Forecast Run ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Level');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_value_regex' = 'asset|zone|portfolio|balancing_authority');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `confidence_level_p10_mw` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level P10 Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `confidence_level_p50_mw` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level P50 Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `confidence_level_p90_mw` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level P90 Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_bias_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_horizon_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Hours');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|estimated|missing_input|model_failure');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'day_ahead|hour_ahead|real_time|week_ahead|month_ahead');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_uncertainty_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Uncertainty Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecast_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecasted_capacity_factor` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Capacity Factor');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecasted_curtailment_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Curtailment Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `forecasted_generation_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Generation Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `grid_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Grid Constraint Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration Minutes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `locational_marginal_price_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) United States Dollar (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `locational_marginal_price_usd_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `market_clearing_price_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Market Clearing Price United States Dollar (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `market_clearing_price_usd_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `net_generation_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Generation Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `persistence_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Persistence Forecast Megawatt (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate Megawatt (MW) per Minute');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `renewable_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Renewable Technology Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `renewable_technology_type` SET TAGS ('dbx_value_regex' = 'solar_pv|wind_onshore|wind_offshore|hydro_run_of_river|biomass|geothermal');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ALTER COLUMN `weather_data_source` SET TAGS ('dbx_business_glossary_term' = 'Weather Data Source');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` SET TAGS ('dbx_subdomain' = 'load_planning');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `peak_demand_id` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `btm_solar_reduction_mw` SET TAGS ('dbx_business_glossary_term' = 'Behind-the-Meter (BTM) Solar Reduction Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `capex_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Trigger Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `dr_reduction_mw` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Reduction Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `energy_efficiency_reduction_mw` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Reduction Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_value_regex' = 'short_term|seasonal|annual|multi_year|long_term');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_scenario` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_scenario` SET TAGS ('dbx_value_regex' = 'base_case|high_growth|low_growth|extreme_weather|conservation|electrification');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_season` SET TAGS ('dbx_business_glossary_term' = 'Forecast Season');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_season` SET TAGS ('dbx_value_regex' = 'summer|winter|spring|fall|annual');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|revised|archived');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'system_peak|coincident_peak|non_coincident_peak|zonal_peak|substation_peak|feeder_peak');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecast_year` SET TAGS ('dbx_business_glossary_term' = 'Forecast Year');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `forecasted_temperature` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Temperature');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `irp_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Integrated Resource Plan (IRP) Filing Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `irp_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Resource Plan (IRP) Filing Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `net_peak_demand_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Peak Demand Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `normal_temperature` SET TAGS ('dbx_business_glossary_term' = 'Normal Temperature');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `peak_date` SET TAGS ('dbx_business_glossary_term' = 'Peak Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `peak_hour_end` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour End');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `peak_hour_start` SET TAGS ('dbx_business_glossary_term' = 'Peak Hour Start');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `required_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Required Capacity Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `reserve_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Reserve Margin Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `rto_iso_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Submission Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `rto_iso_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Submission Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `temperature_sensitivity_mw_per_degree` SET TAGS ('dbx_business_glossary_term' = 'Temperature Sensitivity Megawatts (MW) per Degree');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `temperature_unit` SET TAGS ('dbx_value_regex' = 'fahrenheit|celsius');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` SET TAGS ('dbx_subdomain' = 'load_planning');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `weather_input_id` SET TAGS ('dbx_business_glossary_term' = 'Weather Input Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `atmospheric_pressure_hpa` SET TAGS ('dbx_business_glossary_term' = 'Atmospheric Pressure (Hectopascals)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `cloud_cover_percent` SET TAGS ('dbx_business_glossary_term' = 'Cloud Cover (Percent)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|missing|interpolated|estimated');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `dew_point_c` SET TAGS ('dbx_business_glossary_term' = 'Dew Point (Celsius)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `ensemble_member_number` SET TAGS ('dbx_business_glossary_term' = 'Ensemble Member ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `ensemble_member_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `ensemble_member_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Score');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Issue Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecast Lead Time (Hours)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'deterministic|ensemble|probabilistic|nowcast');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_update_cycle` SET TAGS ('dbx_business_glossary_term' = 'Forecast Update Cycle');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `forecast_valid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Valid Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `is_historical_reforecast` SET TAGS ('dbx_business_glossary_term' = 'Is Historical Reforecast');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `nwp_model_source` SET TAGS ('dbx_business_glossary_term' = 'Numerical Weather Prediction (NWP) Model Source');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `nwp_model_source` SET TAGS ('dbx_value_regex' = 'GFS|ECMWF|NAM|HRRR|WRF|CUSTOM');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `precipitation_mm` SET TAGS ('dbx_business_glossary_term' = 'Precipitation (Millimeters)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `precipitation_probability_percent` SET TAGS ('dbx_business_glossary_term' = 'Precipitation Probability (Percent)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `relative_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity (Percent)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `snow_depth_cm` SET TAGS ('dbx_business_glossary_term' = 'Snow Depth (Centimeters)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `solar_irradiance_w_per_m2` SET TAGS ('dbx_business_glossary_term' = 'Solar Irradiance (Watts Per Square Meter)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `source_file_name` SET TAGS ('dbx_business_glossary_term' = 'Source File Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `spatial_resolution_km` SET TAGS ('dbx_business_glossary_term' = 'Spatial Resolution (Kilometers)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `temporal_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Temporal Resolution (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `visibility_km` SET TAGS ('dbx_business_glossary_term' = 'Visibility (Kilometers)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `weather_station_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Station ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `wind_direction_degrees` SET TAGS ('dbx_business_glossary_term' = 'Wind Direction (Degrees)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `wind_gust_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Gust Speed (Meters Per Second)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`weather_input` ALTER COLUMN `wind_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (Meters Per Second)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` SET TAGS ('dbx_subdomain' = 'renewable_modeling');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `accuracy_metric_mae` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Metric Mean Absolute Error (MAE)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `accuracy_metric_mape` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Metric Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `accuracy_metric_rmse` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Metric Root Mean Squared Error (RMSE)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `champion_challenger_flag` SET TAGS ('dbx_business_glossary_term' = 'Champion Challenger Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `deployment_environment` SET TAGS ('dbx_value_regex' = 'development|staging|production|sandbox');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Model Documentation Uniform Resource Locator (URL)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Execution Frequency');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `execution_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|on_demand');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'load|generation|renewable|demand_response|price|capacity');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term|real_time|day_ahead|seasonal');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'Model Framework');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `hyperparameters` SET TAGS ('dbx_business_glossary_term' = 'Hyperparameters');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `input_feature_set` SET TAGS ('dbx_business_glossary_term' = 'Input Feature Set');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Model Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'development|testing|champion|challenger|retired|deprecated');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `output_granularity` SET TAGS ('dbx_business_glossary_term' = 'Output Granularity');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `output_granularity` SET TAGS ('dbx_value_regex' = '5_minute|15_minute|hourly|daily|monthly|annual');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Email');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Model Owner Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `training_end_date` SET TAGS ('dbx_business_glossary_term' = 'Training End Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `validation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Period End Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `validation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^v?[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`model` ALTER COLUMN `weather_data_source` SET TAGS ('dbx_business_glossary_term' = 'Weather Data Source');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` SET TAGS ('dbx_subdomain' = 'renewable_modeling');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `accuracy_id` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `interval_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Reading Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `load_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `meter_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Point Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `meter_read_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `state_estimation_run_id` SET TAGS ('dbx_business_glossary_term' = 'State Estimation Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `absolute_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Absolute Error in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `actual_value_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Value in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Comparison Result');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `benchmark_comparison` SET TAGS ('dbx_value_regex' = 'better|worse|equivalent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `bias_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|estimated|missing');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `day_type` SET TAGS ('dbx_business_glossary_term' = 'Day Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `day_type` SET TAGS ('dbx_value_regex' = 'weekday|weekend|holiday');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `forecast_horizon_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon in Hours');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'load|generation|renewable|demand_response|price|reserve');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `forecasted_value_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Value in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `granularity_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Granularity Level');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `granularity_level` SET TAGS ('dbx_value_regex' = 'system|zone|substation|feeder|customer_segment|asset');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `improvement_opportunity_flag` SET TAGS ('dbx_business_glossary_term' = 'Improvement Opportunity Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `mae_mw` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Error (MAE) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Measurement Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Measurement Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `peak_error_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Error in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `peak_error_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Peak Error Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `percentage_error` SET TAGS ('dbx_business_glossary_term' = 'Percentage Error');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `regulatory_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Met Indicator');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `rmse_mw` SET TAGS ('dbx_business_glossary_term' = 'Root Mean Squared Error (RMSE) in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'winter|spring|summer|fall');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `squared_error` SET TAGS ('dbx_business_glossary_term' = 'Squared Error');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `time_of_day_category` SET TAGS ('dbx_business_glossary_term' = 'Time of Day Category');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `time_of_day_category` SET TAGS ('dbx_value_regex' = 'overnight|morning_ramp|midday|evening_peak|night');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `weather_regime` SET TAGS ('dbx_business_glossary_term' = 'Weather Regime');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ALTER COLUMN `weather_regime` SET TAGS ('dbx_value_regex' = 'normal|extreme_heat|extreme_cold|high_wind|low_wind|storm');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` SET TAGS ('dbx_subdomain' = 'market_strategy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Resource Plan (IRP) Scenario Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `load_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `parent_scenario_irp_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Scenario Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `battery_storage_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Capacity Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `capacity_market_assumption` SET TAGS ('dbx_business_glossary_term' = 'Capacity Market Assumption');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `capacity_market_assumption` SET TAGS ('dbx_value_regex' = 'none|energy_only|capacity_market|hybrid');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `demand_response_credit_mw` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Credit Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `distributed_energy_resource_penetration_pct` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Penetration Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `economic_growth_assumption` SET TAGS ('dbx_business_glossary_term' = 'Economic Growth Assumption');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `economic_growth_assumption` SET TAGS ('dbx_value_regex' = 'low|reference|high|recession');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `electrification_assumption` SET TAGS ('dbx_business_glossary_term' = 'Electrification Assumption');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `electrification_assumption` SET TAGS ('dbx_value_regex' = 'low|reference|high');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `energy_efficiency_savings_gwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Savings Gigawatt-Hours (GWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filed Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `fossil_capacity_retirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Fossil Fuel Capacity Retirement Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `load_growth_assumption_pct` SET TAGS ('dbx_business_glossary_term' = 'Load Growth Assumption Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `modeling_software` SET TAGS ('dbx_business_glossary_term' = 'Modeling Software');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `natural_gas_price_trajectory` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Price Trajectory');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `natural_gas_price_trajectory` SET TAGS ('dbx_value_regex' = 'low|reference|high|volatile');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `peak_demand_growth_assumption_pct` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Growth Assumption Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `planning_horizon_end_year` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Year');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `planning_horizon_start_year` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Year');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `puc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Docket Number');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `reliability_metric_lole` SET TAGS ('dbx_business_glossary_term' = 'Loss of Load Expectation (LOLE) Reliability Metric');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `renewable_capacity_addition_mw` SET TAGS ('dbx_business_glossary_term' = 'Renewable Capacity Addition Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `reserve_margin_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Reserve Margin Target Percentage');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `retirement_schedule_assumption` SET TAGS ('dbx_business_glossary_term' = 'Retirement Schedule Assumption');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `retirement_schedule_assumption` SET TAGS ('dbx_value_regex' = 'baseline|accelerated|delayed|policy_driven');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Scenario Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_notes` SET TAGS ('dbx_business_glossary_term' = 'Scenario Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_business_glossary_term' = 'Scenario Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|filed|archived');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'base|sensitivity|alternative|stress_test|bookend');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `sensitivity_variable` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity Variable');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `stakeholder_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Feedback Summary');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `technology_cost_assumption` SET TAGS ('dbx_business_glossary_term' = 'Technology Cost Assumption');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `technology_cost_assumption` SET TAGS ('dbx_value_regex' = 'low|reference|high');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `total_co2_emissions_million_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Dioxide (CO2) Emissions Million Tons');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `total_resource_cost_npv_million` SET TAGS ('dbx_business_glossary_term' = 'Total Resource Cost Net Present Value (NPV) Million Dollars');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `total_resource_cost_npv_million` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `transmission_expansion_assumption` SET TAGS ('dbx_business_glossary_term' = 'Transmission Expansion Assumption');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `transmission_expansion_assumption` SET TAGS ('dbx_value_regex' = 'none|limited|moderate|aggressive');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `weather_normalization_method` SET TAGS ('dbx_business_glossary_term' = 'Weather Normalization Method');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ALTER COLUMN `weather_normalization_method` SET TAGS ('dbx_value_regex' = 'historical_average|climate_adjusted|extreme_weather');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` SET TAGS ('dbx_subdomain' = 'market_strategy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Constraining Path Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Zone ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_auction_clearing_price_per_mw_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Auction Clearing Price (per MW-Day)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_auction_clearing_price_per_mw_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_deficiency_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Deficiency (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_export_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Export Limit (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_import_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Import Limit (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `capacity_surplus_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Surplus (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `deficiency_penalty_rate_per_mw_day` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Penalty Rate (per MW-Day)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `deficiency_penalty_rate_per_mw_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `demand_response_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Capacity Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `energy_storage_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Capacity Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `expected_unserved_energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Expected Unserved Energy (EUE) (MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `flexible_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Flexible Capacity Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `forecast_confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `installed_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity (ICAP) Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `local_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Local Capacity Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `loss_of_load_probability_target` SET TAGS ('dbx_business_glossary_term' = 'Loss of Load Probability (LOLP) Target');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `net_qualifying_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Qualifying Capacity (NQC) (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `planning_reserve_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Planning Reserve Margin (PRM) Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `renewable_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Renewable Capacity Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `requirement_status` SET TAGS ('dbx_value_regex' = 'draft|proposed|approved|active|superseded|archived');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'installed_capacity|planning_reserve_margin|net_qualifying_capacity|resource_adequacy|reliability_must_run');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `thermal_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Thermal Capacity Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `transmission_constraint_adjustment_mw` SET TAGS ('dbx_business_glossary_term' = 'Transmission Constraint Adjustment (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `unforced_capacity_requirement_mw` SET TAGS ('dbx_business_glossary_term' = 'Unforced Capacity (UCAP) Requirement (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ALTER COLUMN `weather_normalization_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Normalization Applied Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` SET TAGS ('dbx_subdomain' = 'market_strategy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `superseded_by_forecast_energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Forecast ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `ancillary_services_price_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Price (USD per MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `capacity_price_usd_per_mw_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Price (USD per MW-Day)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `carbon_price_usd_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Carbon Price (USD per Ton CO2)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `coal_price_usd_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Coal Price (USD per Ton)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level (Percent)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_identifier` SET TAGS ('dbx_business_glossary_term' = 'Forecast Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_methodology` SET TAGS ('dbx_business_glossary_term' = 'Forecast Methodology');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_methodology` SET TAGS ('dbx_value_regex' = 'fundamental|statistical|machine_learning|hybrid|expert_judgment');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_source_system` SET TAGS ('dbx_business_glossary_term' = 'Forecast Source System');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|approved|published|superseded|archived');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'short_term|mid_term|long_term|day_ahead|real_time|seasonal');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `hedging_strategy_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedging Strategy Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `lcoe_calculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Levelized Cost of Energy (LCOE) Calculation Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `lmp_congestion_component_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Congestion Component (USD per MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `lmp_energy_component_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Energy Component (USD per MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `lmp_loss_component_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Loss Component (USD per MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `lmp_total_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Total (USD per MWh)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|forward');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `natural_gas_price_usd_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Price (USD per MMBtu)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `ppa_valuation_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Valuation Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `renewable_energy_credit_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Price (USD)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `renewable_generation_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Renewable Generation Forecast (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `transmission_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Transmission Constraint Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `weather_scenario` SET TAGS ('dbx_business_glossary_term' = 'Weather Scenario');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ALTER COLUMN `weather_scenario` SET TAGS ('dbx_value_regex' = 'normal|hot|cold|extreme_heat|extreme_cold|mild');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` SET TAGS ('dbx_subdomain' = 'market_strategy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `parent_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Zone ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `area_square_km` SET TAGS ('dbx_business_glossary_term' = 'Area Square Kilometers (km²)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `climate_zone` SET TAGS ('dbx_business_glossary_term' = 'Climate Zone');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `der_penetration_percent` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Penetration Percent');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `feeder_count` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder Count');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `forecast_accuracy_mape` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `forecast_model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `geographic_boundary_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Well-Known Text (WKT)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `installed_generation_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Installed Generation Capacity Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `peak_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Load Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `primary_weather_station_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Weather Station ID');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `renewable_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Renewable Capacity Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `rto_iso_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `rto_iso_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Zone Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `substation_count` SET TAGS ('dbx_business_glossary_term' = 'Substation Count');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level Kilovolts (kV)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_business_glossary_term' = 'Zone Code');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_name` SET TAGS ('dbx_business_glossary_term' = 'Zone Name');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_business_glossary_term' = 'Zone Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `zone_type` SET TAGS ('dbx_value_regex' = 'load_zone|weather_zone|transmission_zone|distribution_feeder_zone|market_zone|planning_zone');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`zone` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` SET TAGS ('dbx_subdomain' = 'market_strategy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `baseline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `superseded_by_run_forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Run Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `compute_cluster_code` SET TAGS ('dbx_business_glossary_term' = 'Compute Cluster Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `configuration_parameters` SET TAGS ('dbx_business_glossary_term' = 'Configuration Parameters');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `convergence_iterations` SET TAGS ('dbx_business_glossary_term' = 'Convergence Iterations');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `convergence_status` SET TAGS ('dbx_business_glossary_term' = 'Convergence Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `convergence_status` SET TAGS ('dbx_value_regex' = 'converged|not_converged|partial_convergence|timeout');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `convergence_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Convergence Tolerance');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `cpu_hours_consumed` SET TAGS ('dbx_business_glossary_term' = 'Central Processing Unit (CPU) Hours Consumed');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration in Seconds');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `execution_environment` SET TAGS ('dbx_business_glossary_term' = 'Execution Environment');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `execution_environment` SET TAGS ('dbx_value_regex' = 'production|staging|development|test|validation');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `forecast_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `forecast_horizon_hours` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon in Hours');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `forecast_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'load|generation|renewable|price|demand_response');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'system|zone|substation|feeder|service_territory');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `input_data_snapshot_code` SET TAGS ('dbx_business_glossary_term' = 'Input Data Snapshot Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `input_data_snapshot_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{10,50}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `interval_resolution_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Resolution in Minutes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `memory_peak_gb` SET TAGS ('dbx_business_glossary_term' = 'Memory Peak in Gigabytes (GB)');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `output_record_count` SET TAGS ('dbx_business_glossary_term' = 'Output Record Count');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `output_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Output Validation Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `output_validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_validated');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `published_flag` SET TAGS ('dbx_business_glossary_term' = 'Published Flag');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed|cancelled|partial');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'scheduled|manual|event_triggered|backfill|reforecast|validation');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Event');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `validation_error_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `validation_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Warning Count');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `warning_message` SET TAGS ('dbx_business_glossary_term' = 'Warning Message');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `weather_data_source` SET TAGS ('dbx_business_glossary_term' = 'Weather Data Source');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_run` ALTER COLUMN `weather_scenario` SET TAGS ('dbx_business_glossary_term' = 'Weather Scenario');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`planning_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`planning_period` SET TAGS ('dbx_subdomain' = 'market_strategy');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`planning_period` ALTER COLUMN `planning_period_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Identifier');
ALTER TABLE `energy_utilities_ecm`.`forecast`.`planning_period` ALTER COLUMN `previous_planning_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
