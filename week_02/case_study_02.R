# Case 2
# 2024. 09. 10

# import library
library(tidyverse)

# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS_v4/tmp_USW00014733_14_0_1/station.csv"

#the next line tells the NASA site to create the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")

# the next lines download the data
temp=read_csv(dataurl, 
              na="999.90", # tell R that 999.90 means missing in this dataset
              skip=1, # we will use our own column names as below so we'll skip the first row
              col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                            "APR","MAY","JUN","JUL",  
                            "AUG","SEP","OCT","NOV",  
                            "DEC","DJF","MAM","JJA",  
                            "SON","metANN"))

# renaming is necessary because they used dashes ("-")
# in the column names and R doesn't like that.

View(temp)
summary(temp)
glimpse(temp)

# Graph the annual mean temperature in June, July and August (JJA) using ggplot

g <- ggplot(temp, aes(x=YEAR, y=JJA))+
  geom_point()+
  geom_line()+
  geom_smooth()+ # Add a smooth line with geom_smooth()
  xlab("YEAR")+
  ylab("Annual mean temperature (°C)")+ # Add informative axis labels using xlab() and ylab() including units
  ggtitle("Annual Mean Tempearture in June, July and August")+ # Add a graph title with ggtitle()
  theme(plot.title = element_text(hjust=0.5)) # Adjust the title in center

# Save a graphic to a png file using png() and dev.off() OR ggsave
ggsave("case2.png")

png("case2_2.png")
print(g)
dev.off()

# Click ‘Source’ in RStudio to run the script from beginning to end to re-run the entire process

