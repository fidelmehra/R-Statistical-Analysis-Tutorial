## Plotting and Visualization (continued)

Base R (continued):
```r
abline(lm(mpg ~ wt, data = mydf), col = "red", lwd = 2)
par(mfrow = c(1,2))
qqnorm(mydf$mpg); qqline(mydf$mpg)
boxplot(scale(mydf[,c("mpg","wt","hp")]), main = "Scaled Variables")
par(mfrow = c(1,1))
```

ggplot2:
```r
library(ggplot2)
# Histogram and density
mydf %>% ggplot(aes(mpg)) +
  geom_histogram(aes(y = ..density..), bins = 15, fill = "#69b3a2") +
  geom_density(color = "#1b7837", linewidth = 1) +
  theme_minimal()
# Boxplot with jitter
mydf %>% ggplot(aes(x = factor(cyl), y = mpg, fill = factor(cyl))) +
  geom_boxplot(alpha = 0.6) +
  geom_jitter(width = 0.1, alpha = 0.6) +
  theme_minimal() + labs(x = "Cylinders", fill = "Cyl")
# Scatter with regression line
mydf %>% ggplot(aes(wt, mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE)
# Faceting by a factor
mydf %>% ggplot(aes(hp, mpg)) +
  geom_point() +
  facet_wrap(~ cyl)
```

Tips:
- Always label axes and units. Use theme_minimal() or theme_classic() for clarity.
- For many groups, consider violin + boxplot overlays.


## Reproducibility Tips
- Use scripts or Quarto (.qmd) to combine code, outputs, and narrative.
- set.seed() before simulations or resampling.
- Record package versions; consider renv::init() to lock dependencies.
- Keep raw data read-only; write cleaned data to a derived folder.


## Beginner Workflow Checklist
1) Import data and inspect with glimpse/summary
2) Clean data (types, missing values, factor labels)
3) Visualize distributions and relationships
4) Choose appropriate test/model based on question and data type
5) Check assumptions; adjust with robust/non-parametric methods if needed
6) Report estimates with confidence intervals and effect sizes
7) Visualize and communicate clearly

## Advanced Guidance
- Robust alternatives: MASS::rlm for robust regression; sandwich + lmtest for robust SEs.
- GLMs: glm(y ~ x, family = binomial) for logistic; poisson/quasipoisson for counts.
- Multiple testing: p.adjust(pvals, method = "BH") for FDR control.
- Model selection: AIC via stepAIC(MASS) or information-theoretic model averaging (MuMIn).
- Cross-validation: rsample and tidymodels for resampling and model tuning.


## Resources and Further Reading
- R for Data Science (2e): https://r4ds.hadley.nz/
- Base R manuals (CRAN): https://cran.r-project.org/manuals.html
- Modern Applied Statistics with S (MASS): https://cran.r-project.org/package=MASS
- effectsize package docs: https://easystats.github.io/effectsize/
- rstatix reference: https://rpkgs.datanovia.com/rstatix/
- ggplot2 book: https://ggplot2-book.org/
- Quick-R (stats quick reference): https://www.statmethods.net/
- UCLA IDRE Statistical Consulting: https://stats.oarc.ucla.edu/

---
This tutorial covered data import/export, descriptive statistics, normal/binomial distributions, t-tests, proportions, chi-square, correlation, regression, ANOVA, non-parametric tests, effect sizes, power, and plotting with step-by-step code and guidance for both beginners and advanced users.
