library(corrplot)
library(ppcor)
library(corrgram)

df = read.table("wines-PCA.txt")

# Change column names regarding the description of the dataset
colnames(df) <- c("fixed_acidity", "volatile_acidity", "citc_acid", "residual_sugar", "chlorides", "free_sulfur_dioxide", "total_sulfur_dioxide", "density", "pH", "sulphates", "alcohol", "quality", "type")
head(df)

# 5 continous variables chosen
data = df[,c("total_sulfur_dioxide", "volatile_acidity", "pH", "sulphates", "chlorides")]
summary(data)

# R matrix of pairwise correlations
corrplot.mixed(
  cor(data),tl.cex=0.6
)

# Matrix of partial correlations
corrplot.mixed(pcor(data)$estimate, tl.cex=0.6)

corrgram(pcor(data)$estimate,
         lower.panel=panel.shade, upper.panel=panel.pie,
         diag.panel=panel.minmax, text.panel=panel.txt
)

# Coefficient of determination (function r2multv() we define in R)
r2multv<-function(x){
  r2s=1-1/(diag(solve(cov(x)))*diag(cov(x)))
  r2s
}
r2multv(data)

# The determinant of R (correlation matrix) as an overall measure of linear relationships.
det(cor(data))

# An eigenanalysis of matrix R, looking for really small eigenvalues.
eigen(cov(data))

