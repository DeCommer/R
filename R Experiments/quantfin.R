#Quant Finance with R Part 1: Intro and Data

library(quantmod)
library(PerformanceAnalytics)

#Beginning Date
dt <- "2020-1-1"

#Calling symbol
aapl <- getSymbols("AAPL", from=dt, auto.assign = F)
#Just closing prices
aaplClose <- getSymbols("AAPL", from=dt, auto.assign = F)[,6]
aapleReturns <- dailyReturn(aaplClose, type="arithmetic")
#Charting 
chartSeries(aapl)


#Quant Finance with R Part 2: Portfolio Analysis

#Get stocks
tickers <- c("AAPL","VOO","CSCO","VWAGY","GM","F","AGCO","SPLG","TMST","MRO","DFS",
             "R","SWBI","PACX","SBUX","PFE","RGR")
weights <- c(.25, .25, .25, .25,.25, .25, .25, .25, .25, .25, .25,
             .25, .25, .25, .25, .25, .25)

portfolioPrices <- NULL
for(ticker in tickers) {
  portfolioPrices <- cbind(portfolioPrices,
                           getSymbols(ticker, from='2019-01-01', periodicity = 'daily', auto.assign = F)[,4])
} #Gets price data from list of stocks

portfolioReturns <- na.omit(ROC(portfolioPrices))

colSums(is.na(portfolioPrices))#Checks for missing data
#compares with S&P 500
benchmarkReturns <- na.omit(ROC(benchmarkPrices))
benchmarkPrices <- getSymbols("^GSPC", from='2019-01-01', periodicity = 'daily', auto.assign = F)[,4]

portfolioReturns <- Return.portfolio(portfolioReturns)

#Beta, alpha, sharpe calculation - risk free rate/daily - 252 = trading days in year
CAPM.beta(portfolioReturns, benchmarkReturns, .035/252)

CAPM.jensenAlpha(portfolioReturns, benchmarkReturns, .035/252)

SharpeRatio(portfolioReturns, .035/252)

table.AnnualizedReturns(portfolioReturns)
table.CalendarReturns(portfolioReturns)

#Quant Finance with R Part 3: Portfolio Optimization




