# project directory
DATA=data
CODE=code
FIGS=figures
ARCHIVE_FILE=precip_prediction.tar.gz

# Set up directories 
CLIMATE=$(DATA)/climate
TEMP=$(DATA)/temp_data
ARCHIVE=$(subst .tar.gz,_archive, $(ARCHIVE_FILE))

# Input files
DAILY_VWC_FILE=$(TEMP)/daily_VWC.csv
SEASON_FILE=$(CLIMATE)/season_table.csv
SW_DATA=$(DATA)/SW_files/sw_output.RData
CLIM_FIGS:=$(FIGS)/VWC_spot_measurements.png

# Get climate scripts 
EXTRACT_SW_SRC=$(CODE)/ExtractData_3Runs.R
GET_SPOT_SRC=$(CODE)/get_spot_VWC.R
VWC_TREAT_SRC=$(CODE)/find_VWC_treatment_effects.R
AGGREGATE_VWC_SRC=$(CODE)/aggregate_VWC_data.R
MAKE_CLIM_VARS_SRC=$(CODE)/make_climate_variables.R
PREP_CLIM_VARS_SRC=$(CODE)/prepare_climate_covariates.R
PLOT_SPRING_VWC_SRC=$(CODE)/plot_spring_soil_moisture_spot_measures.R

# Climate files
SPOT_VWC_FILE=$(TEMP)/spot_VWC.csv
DAILY_SW_TREAT_FILE=$(TEMP)/daily_SOILWAT_VWC_treatments.csv
VWC_FILES=$(TEMP)/quarterly_VWC.csv $(TEMP)/seasonal_VWC.csv $(TEMP)/annual_VWC.csv
CLIM_FILES=$(TEMP)/quarterly_climate.csv $(TEMP)/seasonal_climate.csv $(TEMP)/monthly_climate.csv $(TEMP)/annual_climate.csv $(TEMP)/monthly_climate_from_daily.csv
PREPPED_CLIM_FILE=$(TEMP)/prepped_clim_vars.csv
ALL_CLIM_FILES= $(SPOT_VWC_FILE) $(DAILY_SW_TREAT_FILE) $(VWC_FILES) $(CLIM_FILES) $(PREPPED_CLIM_FILE) $(DAILY_VWC_FILE)

# Plot scripts 
PLOT_THEME_FILE=$(FIGS)/my_plotting_theme.Rdata
PLOT_THEME_SRC=$(CODE)/save_plot_theme.R

