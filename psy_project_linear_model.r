# itri analysis R code

library(pwr)
library(magrittr)
library(dplyr)
library("tidyverse")
library("corrr")
library(lme4)
library(emmeans)
library(WebPower)
library(multcomp)


df <- read.csv('/home/lisz/Desktop/Time_project/your_file.csv')

df$participant <- factor(df$participant)

# make dummy matrix, 2 cause you have 2 levels
#c1<-contr.treatment(2)
# create symmetric matrix with dropped first column
# ncol = number of your levels minus 
#sym_matrix1<-matrix(rep(1/2, 2), ncol=1)
#n_matrix1<-c1-sym_matrix1

# apply new coding matrix 
#contrasts(combined_dataset$nudging_01)<-n_matrix1
#contrasts(combined_dataset$nudging_01)


model_general <- lmer(choice ~ nudging01 + (1|participant), data=df)
summary(model_general)

# post hoc
mcp <- glht(model_general, linfct = mcp(putamen = "Tukey"))
summary(mcp)





# Calculate power

coef_summary <- summary(model_general)$coef
coef_summary

# all ratio odds for each parameter
odds_ratios <- exp(coef_summary[, "Estimate"])


# Set parameters
alpha <- 0.05  # Significance level
effect_size <- 4.47978772  # Use the odds ratio for nudging as the effect size
sample_size <- 32  # Your actual sample size

# calculate probability
total_trials <- nrow(combined_dataset)

# Calculate the proportion of choices that equal 0
#p_0 <- sum(combined_dataset$choice == 'shortest') / total_trials
#p_1 <- sum(combined_dataset$choice == 'alternative') / total_trials


# Assuming you have the intercept coefficient from your logistic regression model
intercept_coefficient <- -2.88998362  # Replace with your actual coefficient

p0 <- 1 / (1 + exp(-intercept_coefficient))
# Assuming you have the coefficient for the predictor variable from your logistic regression model
predictor_coefficient <- 1.49957566  # Replace with your actual coefficient

p1 <- 1 / (1 + exp(-(intercept_coefficient + predictor_coefficient)))

# Calculate power
wp.logistic(n = sample_size, p0 = p_0, p1 = p_1, alpha = 0.05,
power = NULL)

wp.logistic(n = NULL, p0 = p_0, p1 = p_1, alpha = 0.05,
             power = 0.8)


# Specify your desired power and effect size
desired_power <- 0.1494904  # Adjust as needed
effect_size <- 0.27    # Adjust as needed

# Perform power analysis to calculate the required sample size
wp.logistic(p0 = p_0, p1 = p_1, alpha = 0.05,
power = desired_power, family = "Bernoulli", parameter = 0.5)



# post hoc
mcp <- glht(model_group, linfct = mcp(nudging = "Tukey"))
summary(mcp)
