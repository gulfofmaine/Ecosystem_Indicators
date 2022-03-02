# Lobster data ts plot for report


library(tidyverse)
library(patchwork)
library(gmRi)

# Set theme  
theme_set(theme_bw())

# Indicators
all_lob_data <- read_csv(here::here("Processed_Indicators/all_lob_data.csv")) 

all_lob_data$Season <- factor(all_lob_data$Season, levels= c("spring", "summer", "fall", "winter", "all"))
all_lob_data$stat_area <- factor(all_lob_data$stat_area, levels= c("511", "512", "513", "511-513"))

BPs <- all_lob_data %>% 
  mutate(slopeBP1 = case_when(name == "ALSI"~2005,
                             name == "sublegal_cpue"~3000,
                             name == "menh_biomass"~2004,
                             name == "menh_abundance"~2004.1,
                             name == "nefsc_biomass"~1989.2,
                             name == "nefsc_abundance"~1990.1,
                             name == "ME_landings"~1987.6),
         slopeBP2 = case_when(name == "ALSI"~3000,
                              name == "sublegal_cpue"~3000,
                              name == "menh_biomass"~2016,
                              name == "menh_abundance"~2016,
                              name == "nefsc_biomass"~2006.3,
                              name == "nefsc_abundance"~2006.3,
                              name == "ME_landings"~2008.7),
         slopeBP3 = case_when(name == "ALSI"~3000,
                              name == "sublegal_cpue"~3000,
                              name == "menh_biomass"~3000,
                              name == "menh_abundance"~3000,
                              name == "nefsc_biomass"~3000,
                              name == "nefsc_abundance"~3000,
                              name == "ME_landings"~2012.6),
         meanBP1 = case_when(name == "ALSI"~2011.8,
                             name == "sublegal_cpue"~3000,
                             name == "menh_biomass"~2009.7,
                             name == "menh_abundance"~2009.6,
                             name == "nefsc_biomass"~1995.2,
                             name == "nefsc_abundance"~2010.6,
                             name == "ME_landings"~1996.5),
         meanBP2 = case_when(name == "ALSI"~3000,
                             name == "sublegal_cpue"~3000,
                             name == "menh_biomass"~3000,
                             name == "menh_abundance"~3000,
                             name == "nefsc_biomass"~2010.5,
                             name == "nefsc_abundance"~3000,
                             name == "ME_landings"~2009.5))

all_lob_data <- BPs

all_lob_data <- all_lob_data %>% 
  mutate(Period = if_else(Year >= slopeBP3, "Period3", 
                          if_else(Year >= slopeBP2 & Year < slopeBP3, "Period2","Period1")))

namess <- c("ALSI", "sublegal_cpue", "menh_biomass", "menh_abundance", "nefsc_biomass", "nefsc_abundance", "ME_landings")
all_lob_data$name <- factor(all_lob_data$name, levels = namess)

all_lob_data %>% 
  filter(Season == "all",
         stat_area == "511-513",
         name != "NEFSCindex", 
         name != "MEindex") %>% 
  ggplot() +
  geom_line(aes(Year, lob_index)) +
  geom_vline(aes(xintercept = meanBP1), color = "red") +
  geom_vline(aes(xintercept = meanBP2), color = "red") +
  geom_smooth(aes(Year, lob_index, group = Period), method = "lm", se = FALSE) + 
  scale_x_continuous(limits = c(1960, 2020)) + 
  labs(y = "Value") +
  facet_wrap(~name, scales = "free_y", ncol = 3)


