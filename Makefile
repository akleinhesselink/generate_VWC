include config.mk

## all		: Fetch data and run analysis
.PHONY: all 
all: $(CLIM_FIGS) $(PREPPED_CLIM_FILE)

$(FIG_DIR)/VWC_spot_measurements.png: $(PLOT_SPRING_VWC_SRC) $(DRIVERS) $(PLOT_THEME_FILE)
	./$<
 
$(PREPPED_CLIM_FILE): $(TEMP_DIR)/seasonal_climate.csv $(TEMP_DIR)/seasonal_VWC.csv $(PREP_CLIM_VARS_SRC)
	./$(PREP_CLIM_VARS_SRC) $(wordlist 1,2, $^) 

$(CLIM_FILES): $(DRIVERS) $(SEASON_FILE) $(PLOT_THEME_FILE) $(TEMP_DIR) $(MAKE_CLIM_VARS_SRC) 
	./$(MAKE_CLIM_VARS_SRC) $(wordlist 1,4,$^)
	
$(VWC_FILES): $(DAILY_SW_TREAT_FILE) $(PLOT_THEME_FILE) $(AGGREGATE_VWC_SRC) 
	./$(AGGREGATE_VWC_SRC) $(wordlist 1,2, $^)
	
$(DAILY_SW_TREAT_FILE): $(VWC_TREAT_SRC) $(DRIVERS) $(SEASON_FILE) $(DAILY_VWC_FILE) $(SPOT_VWC_FILE) $(PLOT_THEME_FILE)
	./$< $(wordlist 2, $(words $^),$^)

$(SPOT_VWC_FILE): $(DRIVERS) $(SEASON_FILE) $(DAILY_VWC_FILE) $(GET_SPOT_SRC)
	./$(GET_SPOT_SRC) $(wordlist 1,3, $^)

$(DAILY_VWC_FILE): $(EXTRACT_SW_SRC) $(SW_DATA)
	./$^ $(DAILY_VWC_FILE)

$(PLOT_THEME_FILE): $(PLOT_THEME_SRC)
	mkdir -p $(TEMP_DIR)
	mkdir -p $(FIG_DIR)
	./$(PLOT_THEME_SRC)

## archive 		: make tar.gz archive of project
.PHONY: archive 
archive: $(ARCHIVE_FILE)

$(ARCHIVE_FILE): $(ARCHIVE_DIR)
	tar -czf $@ $<
	
$(ARCHIVE_DIR): LICENSE README.md Makefile config.mk $(CODE_DIR) $(DATA_DIR)
	mkdir -p $@
	cp -r $^ $@
	touch $@
	
## clean		: Remove temporary files 
.PHONY: clean
clean:
	rm -rf $(ARCHIVE_DIR)
	rm -f $(ARCHIVE_FILE)
	rm -f $(PLOT_THEME_FILE)
	rm -rf $(TEMP_DIR)/*
	rm -rf $(FIG_DIR)/*
	rm -f Rplots.pdf

## variables	: Print variables.
.PHONY: variables
variables: Makefile 
	@$(foreach V,$(sort $(.VARIABLES)),$(if $(filter-out environment% default automatic,$(origin $V)),$(warning $V=$($V) ($(value $V)))))
	
## help		: Help Menu
.PHONY: help
help: Makefile
	@sed -n 's/^##//p' $<
