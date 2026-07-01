# R Statistical Analysis Tutorial - Author: Fidel Mehra
# Covers: descriptive stats, hypothesis testing, regression, visualisation

# ---- Load Libraries ----
library(ggplot2)
library(dplyr)

# ---- 1. Load Data ----
data(mtcars)
df <- mtcars
cat("Rows:", nrow(df), "Cols:", ncol(df), "\n")
head(df)

# ---- 2. Descriptive Statistics ----
print(summary(df))
cat("Mean MPG:", mean(df$mpg), "\n")
cat("SD MPG:", sd(df$mpg), "\n")
cat("Median MPG:", median(df$mpg), "\n")

# ---- 3. Normality Test ----
shapiro.test(df$mpg)

# Histogram
ggplot(df, aes(x = mpg)) +
  geom_histogram(bins = 10, fill = "steelblue", colour = "white") +
  labs(title = "Distribution of MPG", x = "MPG", y = "Count") +
  theme_minimal()

# Q-Q Plot
qqnorm(df$mpg, main = "Q-Q Plot: MPG")
qqline(df$mpg, col = "red", lwd = 2)

# ---- 4. Correlation Analysis ----
cor_matrix <- cor(df)
print(round(cor_matrix, 2))

# ---- 5. t-Test: Auto vs Manual MPG ----
auto   <- df[df$am == 0, "mpg"]
manual <- df[df$am == 1, "mpg"]
cat("Auto mean MPG:",   mean(auto),   "\n")
cat("Manual mean MPG:", mean(manual), "\n")
t.test(auto, manual, var.equal = FALSE)

# ---- 6. ANOVA: MPG by Cylinders ----
df$cyl_f <- as.factor(df$cyl)
aov_res <- aov(mpg ~ cyl_f, data = df)
print(summary(aov_res))
print(TukeyHSD(aov_res))

# Boxplot
ggplot(df, aes(x = cyl_f, y = mpg, fill = cyl_f)) +
  geom_boxplot(alpha = 0.7) +
  labs(title = "MPG by Cylinders", x = "Cylinders", y = "MPG") +
  theme_minimal() + theme(legend.position = "none")

# ---- 7. Simple Linear Regression ----
lm1 <- lm(mpg ~ wt, data = df)
print(summary(lm1))

ggplot(df, aes(x = wt, y = mpg)) +
  geom_point(colour = "steelblue", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", colour = "red", se = TRUE) +
  labs(title = "MPG vs Weight", x = "Weight (1000 lbs)", y = "MPG") +
  theme_minimal()

# ---- 8. Multiple Linear Regression ----
lm2 <- lm(mpg ~ wt + hp + cyl_f, data = df)
print(summary(lm2))

par(mfrow = c(2,2))
plot(lm2)
par(mfrow = c(1,1))

# ---- 9. Export Summary ----
summary_df <- df %>%
  group_by(cyl_f) %>%
  summarise(n = n(), mean_mpg = round(mean(mpg),2), sd_mpg = round(sd(mpg),2))
print(summary_df)
write.csv(summary_df, "mpg_summary.csv", row.names = FALSE)
cat("Done. Summary saved to mpg_summary.csv\n")
