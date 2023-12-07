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
  exponential_growth = exponential_growth(time_points),
  logistic_growth = logistic_growth(time_points)
)

#plotting the exponential, logistic and actual data curves
ggplot() +
  geom_point(aes(x = t, y = N), data = growth_data, colour = "black") +
  geom_line(aes(x = t, y = exponential_growth), data = model_data, colour = "blue") +
  geom_line(aes(x = t, y = logistic_growth), data = model_data, colour = "yellow") +
  labs(title = "Comparing Exponential and Logistic Growth Curves",
       x = "Time", y = "Population Size") +
  theme_minimal() +
  scale_color_manual(values = c("black", "blue", "yellow")) +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(title = "Model", override.aes = list(linetype = c("blank", "solid", "solid")))) +
  scale_y_continuous(labels = scales::scientific) +
  annotate("text", x = Inf, y = Inf, hjust = 1.1, vjust = 1.1, label = "Black: Actual Data\nBlue: Exponential\nRed: Logistic", size = 3)

  
#plotting the exponential, logistic and actual data curves on a logarithm scale
ggplot() +
  geom_point(aes(x = t, y = N), data = growth_data, colour = "black") +
  geom_line(aes(x = t, y = exponential_growth), data = model_data, colour = "blue") +
  geom_line(aes(x = t, y = logistic_growth), data = model_data, colour = "yellow") +
  labs(title = "Comparing Exponential and Logistic Growth Curves (Log10 Scale)",
       x = "Time", y = "Population Size (log10 scale)") +
  theme_minimal() +
  scale_y_log10() +  # Apply logarithm scale transformation to y-axis
  scale_color_manual(values = c("black", "blue", "yellow")) +
  theme(legend.position = "bottom") +
  guides(color = guide_legend(title = "Model", override.aes = list(linetype = c("blank", "solid", "solid")))) +
  annotate("text", x = Inf, y = Inf, hjust = 1.1, vjust = 1.1, label = "Black: Actual Data\nBlue: Exponential\nRed: Logistic", size = 3)
