# Plot for report

library(tidyverse)
library(patchwork)
library(gmRi)

# Set theme  
theme_set(theme_bw())

# Indicators
allIndicators <- read_csv(here::here("Processed_Indicators/allIndicators.csv"))
allIndicators$Season <- factor(allIndicators$Season, levels= c("spring", "summer", "fall", "winter", "all"))
allIndicators$stat_area <- factor(allIndicators$stat_area, levels= c("511", "512", "513", "511-513"))

indicator <- data.frame("name" = unique(allIndicators$Indicator))
indicator <- indicator %>% 
  mutate(long_name = case_when(name == "fvcom_bt"~"bottom temperature",
                               name == "fvcom_sst"~"sea surface temperature_FVCOM",
                               name == "oisst"~"sea surface temperature_OISST",
                               name == "fvcom_bs"~"bottom salinity",
                               name == "fvcom_sss"~"surface salinity",
                               name == "mcc"~"Maine Coastal Current",
                               name == "stratification"~"Stratification",
                               name == "nefsc_biomass"~"NEFSC predator biomass",
                               name == "nefsc_abundance"~"NEFSC predator abundance",
                               name == "menh_abundance"~"ME/NH predator abundance",
                               name == "menh_biomass"~"ME/NH predator biomass",
                               name == "nefsc_size_spectra_slope"~"NEFSC size spectra slope",
                               name == "menh_size_spectra_slope"~"ME/NH size spectra slope",
                               name == "cpr_FirstMode"~"Small zooplankton index",
                               name == "cpr_SecondMode"~"Calanus index"))

BPs <- indicator %>% 
  mutate(slopeBP = case_when(name == "fvcom_bt"~3000,
                               name == "fvcom_sst"~1990.9,
                               name == "oisst"~1992,
                               name == "fvcom_bs"~2005.18,
                               name == "fvcom_sss"~2007.94,
                               name == "mcc"~2008,
                               name == "stratification"~3000,
                               name == "nefsc_biomass"~1998,
                               name == "nefsc_abundance"~2007,
                               name == "menh_abundance"~2003,
                               name == "menh_biomass"~2011,
                               name == "nefsc_size_spectra_slope"~3000,
                               name == "menh_size_spectra_slope"~3000,
                               name == "cpr_FirstMode"~3000,
                               name == "cpr_SecondMode"~1987),
         meanBP1 = case_when(name == "fvcom_bt"~2009,
                             name == "fvcom_sst"~2009,
                             name == "oisst"~2009,
                             name == "fvcom_bs"~1992.5,
                             name == "fvcom_sss"~1992,
                             name == "mcc"~1993.4,
                             name == "stratification"~2005,
                             name == "nefsc_biomass"~2009.4,
                             name == "nefsc_abundance"~1990,
                             name == "menh_abundance"~2011,
                             name == "menh_biomass"~2014,
                             name == "nefsc_size_spectra_slope"~2009,
                             name == "menh_size_spectra_slope"~2010.85,
                             name == "cpr_FirstMode"~1989.69,
                             name == "cpr_SecondMode"~1975.42),
         meanBP2 = case_when(name == "fvcom_bt"~3000,
                             name == "fvcom_sst"~3000,
                             name == "oisst"~3000,
                             name == "fvcom_bs"~2010.6,
                             name == "fvcom_sss"~2008,
                             name == "mcc"~2010.6,
                             name == "stratification"~3000,
                             name == "nefsc_biomass"~3000,
                             name == "nefsc_abundance"~2009.5,
                             name == "menh_abundance"~3000,
                             name == "menh_biomass"~3000,
                             name == "nefsc_size_spectra_slope"~3000,
                             name == "menh_size_spectra_slope"~3000,
                             name == "cpr_FirstMode"~2001.5,
                             name == "cpr_SecondMode"~3000))

allIndicators <- allIndicators %>% 
  left_join(indicator, by = c("Indicator" = "name")) %>% 
  left_join(BPs, by = c("Indicator" = "name", "long_name"))

allIndicators <- allIndicators %>% 
  mutate(Period = if_else(Year <= slopeBP, "Period1", "Period2"))

allIndicators$Indicator <- factor(allIndicators$Indicator, levels = indicator$name)
allIndicators$long_name <- factor(allIndicators$long_name, levels = indicator$long_name)

allIndicators %>% 
  filter(Season == "all",
         stat_area == "511-513") %>% 
  ggplot() +
  geom_line(aes(Year, Value)) +
  geom_vline(aes(xintercept = meanBP1), color = "red") +
  geom_vline(aes(xintercept = meanBP2), color = "red") +
  geom_smooth(aes(Year, Value, group = Period), method = "lm", se = FALSE) + 
  scale_x_continuous(limits = c(1960, 2020)) + 
  facet_wrap(~long_name, scales = "free_y", ncol = 3)


