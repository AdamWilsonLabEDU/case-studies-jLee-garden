### Case Study 5
## 2024. 10. 1 
## Jeongwon Lee

# Generate a polygon that includes all land in NY that is within 10km of the Canadian border (not including the great lakes).

# Calculate it’s area in km^2. How much land will you need to defend from the Canadians?

library(spData)
library(sf)
library(tidyverse)
library(ggplot2)
library(ggmap)

#load 'world' data from spData package
data(world)  
# load 'states' boundaries from spData package
data(us_states)
plot(world[1])  #plot if desired
plot(us_states[1]) #plot if desired

# Define drojection
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
world <- st_transform(world, albers)
us_states <- st_transform(us_states, albers)

# Extract only New York States
ny <- us_states %>% filter(NAME == "New York") %>% select(geometry) 

# Extract Canadaian border
canada <- world %>% filter(name_long == "Canada") %>% select(geom) 
plot(canada)

# Buffer Canada 10km
canada_buf <- st_buffer(canada, units::set_units(10, km))

# Intersection of Canada and New York
can_ny_int <- st_intersection(canada_buf, ny)

# Calculate area of border
st_area(can_ny_int) %>% units::set_units(km^2)

# Visualize them on the map
ggplot() +
  geom_sf(data = ny) +
  geom_sf(data = can_ny_int,  colour = "red", fill = "red") + 
  ggtitle("New York Land within 10km")

library(leaflet)

# Reproject it

can_ny_int4326 <- st_transform(can_ny_int, 4326) 

leaflet() %>%
  addTiles() %>% 
  addPolygons(data = can_ny_int4326, color = "black", weight = 2, opacity = 0.7, fillColor = "red", fillOpacity = 0.5, popup = ~ as.character(st_area(canada_buf4326))) %>%
  addLegend(position = "bottomright", colors = "black", labels = "Border Area", title = "Legend") %>%
  setView(lng = -75, lat = 45, zoom = 5)

# Save your script as a .R or .Rmd in your course reposicentory
