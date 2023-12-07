#Script for comparing exponential and lgoistic growth curves

#install and load necessary library
install.packages(gglplot2)
library(ggplot2)

#read in the growth data
growth_data <- read.csv("experiment1.csv")

#define the parameters used for the models
N0 <- 1320        # Initial population size
r <- 0.0095218    # Growth rate
K <- 5.979e+10    # Carrying capacity

#exponential growth function
exponential_growth <- function(t) {
  N0 * exp(r * t)
}

#logistic growth function
logistic_growth <- function(t) {
  (N0 * K * exp(r * t)) / (K - N0 + N0*exp(r*t))
}

#time points used for model predictions
time_points <- growth_data$t

#creating a data frame of the exponential and logistic models
model_data <- data.frame(
  t = time_points,
  N = c(exp_growth(time_points), logistic_growth(time_points)),
  Type = rep(c("Exponential Growth", "Logistic Growth"), each = length(time_points))
)

#plotting the exponential, logistic and actual data curves on a logarithm scale
ggplot(model_data, aes(x = t, y = N, color = Type)) +
  geom_line() +
  labs(title = "Comparison of Exponential and Logistic Growth Models",
       x = "Time", y = "Population Size", color = "Model Type") +
  theme_bw() +
  scale_y_log10() +
  theme(legend.position = "bottom")

