#include config.mk
# project directory
DATA=data
CODE=code
FIGS=figures
ARCHIVE_FILE=precip_prediction.tar.gz

# Set up directories 
CLIMATE=$(DATA)/climate
TEMP=$(DATA)/temp_data
ARCHIVE=$(subst .tar.gz,_archive, $(ARCHIVE_FILE))

# Inputs
USSES_CLIM=lib/USSES_climate
SEASONS=$(USSES_CLIM)/data/season_table.csv
STATION_DAT=$(USSES_CLIM)/data/processed_soil_data/daily_station_dat_rainfall.RDS
SPOT_DAT=$(USSES_CLIM)/data/processed_soil_data/spring_spot_measurements.RDS
SW_DAT=$(DATA)/SW_files/sw_output.RData

# Output files
DAILY_VWC_FILE=$(TEMP)/daily_VWC.csv
SPOT_VWC_FILE=$(TEMP)/spot_VWC.csv
DAILY_SW_TREAT_FILE=$(TEMP)/daily_SOILWAT_VWC_treatments.csv

CLIM_FIGS:=$(FIGS)/VWC_spot_measurements.png

# Get climate scripts 
EXTRACT_SW_SRC=$(CODE)/ExtractData_3Runs.R
GET_SPOT_SRC=$(CODE)/get_spot_VWC.R
FIND_VWC_TREAT_SRC=$(CODE)/find_VWC_treatment_effects.R

# Plot scripts 
PLOT_THEME_FILE=$(FIGS)/my_plotting_theme.Rdata
PLOT_THEME_SRC=$(CODE)/save_plot_theme.R

## all		: Fetch data and run analysis
#.PHONY: all 
#all: $(CLIM_FIGS) $(PREPPED_CLIM_FILE)

#$(FIGS)/VWC_spot_measurements.png: $(PLOT_SPRING_VWC_SRC) $(DRIVERS) $(PLOT_THEME_FILE)
#	./$<
 
#$(PREPPED_CLIM_FILE): $(TEMP)/seasonal_climate.csv $(TEMP)/seasonal_VWC.csv $(PREP_CLIM_VARS_SRC)
#	./$(PREP_CLIM_VARS_SRC) $(wordlist 1,2, $^) 

#$(CLIM_FILES): $(DRIVERS) $(SEASONS) $(PLOT_THEME_FILE) $(TEMP) $(MAKE_CLIM_VARS_SRC) 
#	./$(MAKE_CLIM_VARS_SRC) $(wordlist 1,4,$^)
	
#$(VWC_FILES): $(DAILY_SW_TREAT_FILE) $(PLOT_THEME_FILE) $(AGGREGATE_VWC_SRC) 
#	./$(AGGREGATE_VWC_SRC) $(wordlist 1,2, $^)
	
$(DAILY_SW_TREAT_FILE): $(FIND_VWC_TREAT_SRC) $(SEASONS) $(DAILY_VWC_FILE) $(SPOT_VWC_FILE) $(PLOT_THEME_FILE)
	./$< 

$(SPOT_VWC_FILE): $(GET_SPOT_SRC) $(SEASONS) $(STATION_DAT) $(SPOT_DAT) $(DAILY_VWC_FILE)
	./$< 

$(DAILY_VWC_FILE): $(EXTRACT_SW_SRC) $(SW_DAT)
	./$<

.PHONY: get_clim
get_clim: 
	cd $(USSES_CLIM) && make
	
$(PLOT_THEME_FILE): $(PLOT_THEME_SRC)
	mkdir -p $(TEMP)
	mkdir -p $(FIGS)
	./$(PLOT_THEME_SRC)

## archive 		: make tar.gz archive of project
.PHONY: archive 
archive: $(ARCHIVE_FILE)

$(ARCHIVE_FILE): $(ARCHIVE)
	tar -czf $@ $<
	
$(ARCHIVE): LICENSE README.md Makefile config.mk $(CODE) $(DATA)
	mkdir -p $@
	cp -r $^ $@
	touch $@
	
## clean		: Remove temporary files 
.PHONY: clean
clean:
	rm -rf $(ARCHIVE)
	rm -f $(ARCHIVE_FILE)
	rm -f $(PLOT_THEME_FILE)
	rm -rf $(TEMP)/*
	rm -rf $(FIGS)/*
	rm -f Rplots.pdf

## variables	: Print variables.
.PHONY: variables
variables: Makefile 
	@$(foreach V,$(sort $(.VARIABLES)),$(if $(filter-out environment% default automatic,$(origin $V)),$(warning $V=$($V) ($(value $V)))))
	
## help		: Help Menu
.PHONY: help
help: Makefile
	@sed -n 's/^##//p' $<
