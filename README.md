# United States Death Statistics

The data used in this repository was extracted using the CDC WONDER System's Multiple Cause of Death Files. The following files were used: Provisional Multiple Cause of Death Data and the Current Final Multiple Cause of Death Data. For more information about CDC WONDER, please see: <https://wonder.cdc.gov/>

### Statistical Disclosure Control

From CDC Wonder the following statistical disclosure control is usually employed:

**Provisional Multiple Cause of Death Data:** "Statistics representing one through nine (1-9) deaths are suppressed, in the provisional mortality online database for years 2018 and later. Additional privacy constraints apply to infant mortality statistics for infant age groups and live births denominator population figures. See [Assurance of Confidentiality](#0) for more information."

**Current Final** **Multiple Cause of Death Data:** "Statistics representing fewer than ten (one to nine) deaths or births are suppressed. Population figures are also suppressed when the population represents fewer than ten persons. Additional privacy constraints apply to infant mortality statistics for infant age groups and live births denominator population figures. See Assurance of Confidentiality for more information."

### data 
This folder contains downloaded tables from CDC Wonder.

Current Final Multiple Cause of Death Data from CDC Wonder contains data files with overlapping cause of death years for 2018 – 2020 due to different population estimate files used by CDC Wonder. The numerator (deaths) should not differ since you did not request the data by race. However, the population estimates in each file may differ by race and gender due to differences in the population estimate files. You can use the file name below to identify the files:

  •	final_2018_2021_: The population estimates are U.S. Census Bureau estimates of U.S. national, state, and county resident populations. The 2018-2021 population estimates are six single race postcensal estimates of the July 1 resident population. The population estimates for the years 2018-2021 are postcensal estimates of the July 1, resident population from those      years (e.g., 2018 population estimate are from the Vintage 2018 six single race postcensal series released by the Census Bureau on June 20, 2019, 2019 population estimate are from the Vintage 2018 six single race postcensal series released by the Census Bureau on June 25, 2020, etc). 

  •	final_1999_: The population estimates are U.S. Census Bureau estimates of U.S. national, state, and county resident populations. The year 1999 population estimates are bridged-race intercensal estimates of the July 1 resident population, based on the 1990 and the year 2000 census counts. The year 2000 and year 2010 population estimates are April 1 modified census     counts, with bridged-race categories. The year 2011-2020 population estimates are bridged-race postcensal estimates of the July 1 resident population. The 2001 - 2009 population estimates are bridged-race revised intercensal estimates of the July 1 resident population, based on the year 2000 and the year 2010 census counts (released by NCHS on 10/26/2012). The         2001 - 2009 archive population estimates are bridged-race postcensal estimates of the July 1 resident population. 

Provisional Multiple Cause of Death Data are available on WONDER at the national, state and county level by single race categories, for deaths occurring in years 2018 through last week. Data are based on death certificates for U.S. residents. Each death certificate contains a single underlying cause of death, up to twenty additional multiple causes, and demographic data.

  •	provisional_2018_: The population estimates are single-race estimates based on Bureau of the Census estimates of total U.S., State, and county resident populations. The 2018-2019 population estimates are postcensal estimates of the July 1 resident population. Note that these estimates are based on 6 single race categories: American Indian or Alaska Native (AIAN);   Asian; Black or African American; More than one race; Native Hawaiian or Other Pacific Islander (NHOPI); White. The population estimates are by geographic unit (total United States, State, and county), year, race, sex, and age group. To permit the calculation of infant mortality rates, NCHS live-birth data are included on the file.


### R 
This folder contains an R script to load each and all of the downloaded tables from CDC Wonder. 

### results
This folder contains an aggregated total by year of death for each of the file that was downloaded. It provides a comparison of the total counts (unsuppressed) to the total counts of the suppressed depending on age grouping and gender.

### literature
This folder contains research paper working with suppressed CDC Wonder data.

