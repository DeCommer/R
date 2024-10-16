library(quantmod)
library(PerformanceAnalytics)
library(dygraphs)

monthly_returns <- function(ticker, base_year)
{
  stock <- getSymbols(ticker, src = "yahoo", auto.assign = FALSE)
  stock <- na.omit(stock)
  stock <- stock[, 6]

  horizon <- paste0(as.character(base_year), "/", as.character(Sys.Date()))
  stock <- stock[horizon]

  data <- periodReturn(stock, period = "monthly", type = "arithmetic")

  assign(ticker, data, envir = .GlobalEnv)
}

monthly_returns("SBUX", 2020)
monthly_returns("AAPL", 2020)
monthly_returns("F", 2020)

monthly_returns("VOO", 2020)

returns <- merge.xts(SBUX, AAPL, F, VOO)
colnames(returns) <- c("SBUX", "AAPL", "F", "VOO")

dygraph(returns, main = "Starbucks, Apple, Ford, VanguardS&P") %>%
  dyAxis("y", label = "Monthly Returns", valueRange = c(-0.2,0.5)) %>%
  dyRangeSelector(dateWindow = c("2021-01-01", "2021-11-1")) %>%
  dyOptions(colors = RColorBrewer::brewer.pal(4, "Set2"), strokeWidth = 1.5)

round(tail(returns, n = 5), 4)

curve(dnorm(x,0,1), xlim=c(-10, 10),
      ylim=c(0,.5), col="orange", lwd=3)



