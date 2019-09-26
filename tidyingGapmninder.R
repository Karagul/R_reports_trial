library(dplyr)
library(purrr)
library(ggplot2)
library(tidyverse)
library(readxl)
library(hrbrthemes)
library(scales)
library(countrycode)
library(glue)
library(plotly)
library(crosstalk)
library(DT)
library(gganimate)
library(widgetframe)

theme_set(theme_ft_rc())

path <- "gapminder_messy.xlsx"

combined_data <- excel_sheets(path) %>% 
  map_df(~ {
    
    read_excel(path, sheet = .x, skip=4, trim_ws = TRUE)%>%
      mutate(year=as.integer(.x))
    
  })%>%
  select(country, year, everything())

#inspect head and tail to make sure stacked right

head(combined_data)
tail(combined_data)


#add a continent table using the countrycode package

combined_data <- combined_data %>%
  mutate(continent = countrycode(sourcevar=country, origin="country.name", destination="continent"))
  #select(continent, everything())

combined_data <- combined_data[,c(6,1:5)]
