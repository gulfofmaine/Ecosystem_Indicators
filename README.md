# Ecosystem_Indicators

**About:**

This section of the repository contains code detailing how the indicator data was processed. This readme exists to orient users to the code and lays out the order in which the code should be run for reproducible results. 

## Indicator results

* [SST (OISST)](https://dzaugis.github.io/Ecosystem_Indicators/Code/oisst_Analysis.html)
* [Bottom temperature (FVCOM)](https://dzaugis.github.io/Ecosystem_Indicators/Code/fvcom_bt_Analysis.html)
* [SST (FVCOM)](https://dzaugis.github.io/Ecosystem_Indicators/Code/fvcom_sst_Analysis.html)
* [Sea surface salinity](https://dzaugis.github.io/Ecosystem_Indicators/Code/fvcom_sss_Analysis.html)
* [Bottom salinity](https://dzaugis.github.io/Ecosystem_Indicators/Code/fvcom_bs_Analysis.html)
* [Maine Coastal Current](https://dzaugis.github.io/Ecosystem_Indicators/Code/mcc_Analysis.html)
* [Stratification](https://dzaugis.github.io/Ecosystem_IndicatorsCode/Stratification_Analysis.html)
* [Small zooplankton](https://dzaugis.github.io/Ecosystem_Indicators/Code/cpr_FirstMode_Analysis.html)
* [Calanus](https://dzaugis.github.io/Ecosystem_Indicators/Code/cpr_SecondMode_Analysis.html)
* [ME/NH lobster predator biomass](https://dzaugis.github.io/Ecosystem_Indicators/Code/menh_biomass_Analysis.html)
* [ME/NH lobster predator abundance](https://dzaugis.github.io/Ecosystem_Indicators/Code/menh_abundance_Analysis.html)
* [ME/NH lobster predator size spectra](https://dzaugis.github.io/Ecosystem_Indicators/Code/menh_size_spectra_slope_Analysis.html)
* [NEFSC lobster predator biomass](https://dzaugis.github.io/Ecosystem_Indicators/blob/nefsc_biomass_Analysis.html)
* [NEFSC lobster predator abundance](https://dzaugis.github.io/Ecosystem_Indicators/Code/nefsc_abundance_Analysis.html)
* [NEFSC lobster predator size spectra](https://dzaugis.github.io/Ecosystem_Indicators/Code/nefsc_size_spectra_slope_Analysis.html)

## Data Sources:

Data from the following sources are used in this analysis:

**Physical data**

* [OISSTv2.1](https://www.ncei.noaa.gov/products/optimum-interpolation-sst)
* [FVCOM NECOFS](http://fvcom.smast.umassd.edu/necofs/) hindcast
* [NERACOOS](http://www.neracoos.org/)

**Biological data**

* [NEFSC bottom trawl survey](https://www.fisheries.noaa.gov/about/northeast-ecosystems-surveys)
* [ME/NH inshore trawl survey](https://www.maine.gov/dmr/science-research/projects/trawlsurvey/index.html)
* [Continuous Plankton Recorder](https://www.cprsurvey.org/services/the-continuous-plankton-recorder/)
* [Maine ventless trap survey](https://www.maine.gov/dmr/science-research/species/lobster/research/ventlesstrap.html)
* [Maine lobster landings](https://www.maine.gov/dmr/commercial-fishing/landings/index.html)


## Final indicators

Indicators used in the final analyses can be found in the Processed_Indicators folder in this repositoy.

Several intermediate datasets were generated in the processing of the raw data. These intermediate datasets are availabe in the the ~Box/Mills Lab/Projects/Ecosystem_Indicators folder. They are not necessary to run the analysis. A description of those data are found in the addendum section at the bottom of this README.

## Data Process

OISST and FVCOM netCDF data were predownloaded and stored in ~Box/Res_Data/oisst_mainstays and ~Box/Res_Data/FVCOM_mon_means, respectively. The oisst_mainstays also contains preprocessed SST anomailes used in this analysis with the baseline climatology of 1982-2011. Example scripts to download the data from the source are located in the Exploratory_analysis folder in this repository. 

NEFSC and ME/NH trawl survey data are found in ~Box/Res_Data in the folders NMFS_trawl and Maine_NH_Trawl, respectively. The specific files used can be found in the processing code. 

Maine ventless trap survey data were requested directly from Maine DMR for the subleagal lobster size range of 71-80mm. These raw data are saved as a .xlsx file and located in ~Box/Mills Lab/Projects/Ecosystem_Indicators/Biological_data.

Maine lobster landings were donwloaded from Maine DMR's commercial fishing site.

Continuous Plankton Recorder (CPR) data are the processed principal components of the CPR data and are located in the Processed_Indicators folder in this repository. The CPR data process can be found at [here](https://github.com/gulfofmaine/CPR_Web_Explorer).

## Code

### Initial data processing

* Lobster_data_development.Rmd - initial processing of all lobster data into seasons and NOAA statistical areas
* OISST_shp_extract.Rmd - extracting the appropriate area from the OISST netCDF files using a shapefile of the NOAA statistical areas
* FVCOM_shp_extract.Rmd - extracting the appropriate area from the FVCOM netCDF files using a shapefile of the NOAA statistical areas
* Update_buoy_data.Rmd - downloads data from the NERACOOS buoys
* Stratification_calculation.Rmd - calculated the stratification index using the NERACOOS buoy data
* ME-NH_pred_index_calculation.Rmd - calculation of the ME/NH inshore trawl species based and sized based lobster predator index
* Nefsc_size_spec_calculation.Rmd - calculation of the NEFSC species and sized based lobster predator index
* MCC_index_report.Rmd - calculation of the Maine Coastal Current index
* Indicator_development.Rmd - final cleanup and processing of the intermediate indicators

### Running the analysis

* Lobster_Data_Analysis.Rmd - runs the analysis for each of the lobster datasets
* Indicator_Analysis.Rmd - runs the analysis for each of the ecosystem indicators
* Multivariate_Analysis - runs the multivariate analysis

The Indicator_Analysis.Rmd can be run interactively through RStudio by choosing the Knit with parameters option. This allows the user to select which season, statistical area, and indicator on which to run the analysis. 

### Exploratory analysis

This folder contains some unfinished exploratory analyses and code chunks that might be useful for later projects.

## Addendum

There are several folders located in Box that were not pushed to github. These include the following:

* Data - contains the NERACOOS buoy data, lobster predator list, Maine DMR catch at length data, shapefiles, and testing data
* Indicators - contains indicator data that has been processed but not finalized for analysis
* Biological_data - contains lobster datasets
* Intermediate_cur_data, Intermediate_sal_data, Intermediate_temp_data - contains FVCOM data extracted from the spatial area but still gridded
