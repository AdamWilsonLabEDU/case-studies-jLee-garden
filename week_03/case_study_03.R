# Case 3
# 2024. 09. 17

## Install and load necessary packages
library(ggplot2)
library(gapminder)
library(dplyr)

## Filter data Kuwait

gapminder_filter <- gapminder %>% 
  filter(country != 'Kuwait')

## Plot #1 (the first row of plots)

g1 <- ggplot(gapminder_filter, aes(x = lifeExp, y =  gdpPercap, color = continent, size = pop/100000)) + 
  geom_point() + 
  facet_wrap(~year,nrow=1)  + 
  scale_y_continuous(trans = "sqrt") + 
  theme_bw() + 
  labs(size = "Pop(100k)", "Continent")


# Prepare the data for the second plot

gapminder_continent <- gapminder_filter %>% group_by(continent, year) %>% 
  summarize(gdpPercapweighted = weighted.mean(x = gdpPercap, w = pop), pop = sum(as.numeric(pop)))

## Plot #2 (the second row of plots)

g2 <- ggplot(gapminder_filter, aes(x = year, y = gdpPercap, color = continent)) + 
  geom_point() + 
  geom_line(aes(group = continent)) + 
  geom_line(data=gapminder_continent, aes(x= year, y = gdpPercapweighted), color="black") + 
  geom_point(data=gapminder_continent, aes(x= year, y = gdpPercapweighted, size = pop/100000), color="black") + 
  facet_wrap(~continent, nrow=1) + 
  theme_bw() + 
  labs(size = "Population (100k)", "continent")

# Layout
library(gridExtra)
final_g <- grid.arrange(g1, g2,nrow = 2)

## Save graphical output as a .png file
ggsave("case3.png", final_g)

## Save your script as a .R or .Rmd in your course repository