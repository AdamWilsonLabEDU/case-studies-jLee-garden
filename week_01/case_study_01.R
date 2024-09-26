## CASE STUDY 1
## Sep 5 2024

#Import library
library(ggplot2)
data(iris)

summary(iris)

#Calculate the mean of the Petal.Length field and save it as an object named petal_length_mean
petal_length_mean <- mean(iris$Petal.Length)

#Plot the distribution of the Petal.Length column as a histogram (?hist)
hist(iris$Petal.Length)

ggplot(data = iris, aes(Petal.Length, colour = Species))+
  geom_histogram(binwidth = 0.1, bins=0.1) +
  xlab("Length of Petals")
ylab("count")


ggplot(data = iris, aes(Petal.Length))+
  geom_histogram() +
  abline(v = mean(Petal.Length))+
  xlab("Length of Petals")
ylab("count")


ggplot(data = iris, aes(x = Petal.Length, fill = Species)) +
  geom_histogram(binwidth = 0.1) +
  geom_vline(xintercept = petal_length_mean, col = 'red') +
  xlab("Length of Petals") +
  ylab("Count")
