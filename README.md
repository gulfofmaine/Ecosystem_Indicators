# Ecosystem_Indicators

**About:**

This section of the repository contains code detailing how the indicator data was processed. This readme exists to orient users to the code and lays out the order in which the code should be run for reproducible results. 

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

## Process Order

Data were accessed or requested from the source and processed in R. 
