rm(lists = ls())
library(quantmod)
library(ggplot2)

stock_1 <- getSymbols("aapl", from = "2018-01-01", to = "2021-11-11", auto.assign = F)
colnames(stock_1) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")

head(stock_1)
tail(stock_1)
summary(stock_1)
str(stock_1)

ggplot(stock_1, aes(x = index(stock_1), y = stock_1[,6])) + 
  geom_line(color = "lightgreen") + ggtitle("Stock Prices") +
  xlab("Date") + ylab("Price") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_date(date_labels = "%b %y", date_breaks = "6 months")

stock_1_mm <- subset(stock_1, index(stock_1) >= "2018-01-01")
stock_1_mm10 <- rollmean(stock_1_mm[,6], 10, fill=list(NA, NULL, NA), align="right")
stock_1_mm30 <- rollmean(stock_1_mm[,6], 30, fill=list(NA, NULL, NA), align="right")

stock_1_mm$mm10 <- coredata(stock_1_mm10)
stock_1_mm$mm30 <- coredata(stock_1_mm30)


ggplot(stock_1_mm, aes(x = index(stock_1_mm))) +
  geom_line(aes(y = stock_1_mm[,6], color = "stock_1"), lwd=0.5) + ggtitle("AAPL Prices") +
  geom_line(aes(y = stock_1_mm$mm10, color = "MA10")) +
  geom_line(aes(y = stock_1_mm$mm30, color = "MA30")) + xlab("Date") + ylab("Price") + 
  theme(plot.title = element_text(hjust = 0.5), panel.border = element_blank()) + 
  scale_x_date(date_labels = "%b %y", date_breaks = "3 months") + 
  scale_color_manual("Series", values = c("stock_1" = "chartreuse3", "MA10" = "deeppink2", "MA30" = "steelblue3"))
