# set driversdata directory 
DRIVERS=$(HOME)/driversdata 

# project directory
DATA_DIR=data
CODE_DIR=code
FIG_DIR=figures
ARCHIVE_FILE=precip_prediction.tar.gz

# Set up directories 
CLIMATE_DIR=$(DATA_DIR)/climate
TEMP_DIR=$(DATA_DIR)/temp_data
ARCHIVE_DIR=$(subst .tar.gz,_archive, $(ARCHIVE_FILE))

# climate files
DAILY_VWC_FILE=$(TEMP_DIR)/daily_VWC.csv
SEASON_FILE=$(CLIMATE_DIR)/season_table.csv
SW_DATA=$(DATA_DIR)/SW_files/sw_output.RData
CLIM_FIGS:=$(FIG_DIR)/VWC_spot_measurements.png

# Get climate scripts 
EXTRACT_SW_SRC=$(CODE_DIR)/ExtractData_3Runs.R
GET_SPOT_SRC=$(CODE_DIR)/get_spot_VWC.R
VWC_TREAT_SRC=$(CODE_DIR)/find_VWC_treatment_effects.R
AGGREGATE_VWC_SRC=$(CODE_DIR)/aggregate_VWC_data.R
MAKE_CLIM_VARS_SRC=$(CODE_DIR)/make_climate_variables.R
PREP_CLIM_VARS_SRC=$(CODE_DIR)/prepare_climate_covariates.R
PLOT_SPRING_VWC_SRC=$(CODE_DIR)/plot_spring_soil_moisture_spot_measures.R

# Climate files
SPOT_VWC_FILE=$(TEMP_DIR)/spot_VWC.csv
DAILY_SW_TREAT_FILE=$(TEMP_DIR)/daily_SOILWAT_VWC_treatments.csv
VWC_FILES=$(TEMP_DIR)/quarterly_VWC.csv $(TEMP_DIR)/seasonal_VWC.csv $(TEMP_DIR)/annual_VWC.csv
CLIM_FILES=$(TEMP_DIR)/quarterly_climate.csv $(TEMP_DIR)/seasonal_climate.csv $(TEMP_DIR)/monthly_climate.csv $(TEMP_DIR)/annual_climate.csv $(TEMP_DIR)/monthly_climate_from_daily.csv
PREPPED_CLIM_FILE=$(TEMP_DIR)/prepped_clim_vars.csv
ALL_CLIM_FILES= $(SPOT_VWC_FILE) $(DAILY_SW_TREAT_FILE) $(VWC_FILES) $(CLIM_FILES) $(PREPPED_CLIM_FILE) $(DAILY_VWC_FILE)

# Plot scripts 
PLOT_THEME_FILE=$(FIG_DIR)/my_plotting_theme.Rdata
PLOT_THEME_SRC=$(CODE_DIR)/save_plot_theme.R

