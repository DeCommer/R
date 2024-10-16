library(wooldridge)
library(stargazer)
# install.packages("stargazer")

wage1 <- data.frame(wage1)
head(wage1)

mean(wage1$wage)
sd(wage1$wage)

stargazer(wage1$wage)

wageVar <- subset(wage1, select = c(wage, exper, tenure))

stargazer(wageVar, type="text")

hist(wage1$wage)

table(wage1$educ)
