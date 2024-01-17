
library(dplyr)

#Load Data on to the workspace
Data <- read.csv("date_coordonate_data.csv",TRUE,",")
wetlands <- read.csv("ris-tabular-20240110-225718-e807e9cd85138c2cc4a64189e6f5235d.csv",TRUE,",")

library(tidyverse)

#Create a new variable for the country code to merge it later with the country name. 

Data <- Data %>%
  mutate(CountryCode = substr(nut3, 1, 2))

# Print the updated data frame
print(Data)


#Name the country the cases in the Data are from based on the country code taken from nut3. 

country_lookup <- data.frame(
  CountryCode = c("RO", "HU", "IT", "ES", "DE", "FR", "EL", "AT", "BE", "BG", 
                  "HR", "CY", "CZ", "DK", "EE", "FI", "IE", "LV", "LT", "LU", 
                  "MT", "NL", "PL", "PT", "SK", "SI", "SE"),
  CountryName = c("Romania", "Hungary", "Italy", "Spain", "Germany", "France", 
                  "Greece", "Austria", "Belgium", "Bulgaria", "Croatia", 
                  "Cyprus", "Czech Republic", "Denmark", "Estonia", "Finland", 
                  "Ireland", "Latvia", "Lithuania", "Luxembourg", "Malta", 
                  "Netherlands", "Poland", "Portugal", "Slovakia", "Slovenia", 
                  "Sweden")
)

# Merge the data frames based on 'Country Code'
Data <- Data %>%
  left_join(country_lookup, by = "CountryCode")

# Print the updated data frame
print(Data)

str(Data)



#select the countries required for analysis : Hungary, Greece, Austria and Romania

Data2 <- Data |> 
  filter(CountryCode %in% c("HU", "RO", "EL", "AT"))

# Print the filtered data
print(Data2)



#Filter the Ramsar Wetland Data to contain only the countries in our select data

DataWetlands <- wetlands |> 
  filter(Country %in% c("Hungary", "Romania", "Austria","Greece"))


#select a few columns from Data Wetlands
DataWetlands2 <- DataWetlands %>%
  select(
    Ramsar.Site.No.,
    Site.name,
    Country,
    Last.publication.date,
    Area..ha.,
    Latitude,
    Longitude,
  )

# Print the resulting data frame
print(DataWetlands2)

#Rename the Latitude and longitude of the two data as Lats 1 &2 and Long 1&2 for further analysis. 


# Rename latitude and longitude columns in Data2
Data2 <- Data2 %>%
  rename(latitude_1 = latitude, longitude_1 = longitude)

# Rename latitude and longitude columns in DataWetlands2
DataWetlands2 <- DataWetlands2 %>%
  rename(latitude_2 = Latitude, longitude_2 = Longitude)


#I tried to edit the data to a point where i now need to merge them based on our essential criteria. 17/01/24 20:48

