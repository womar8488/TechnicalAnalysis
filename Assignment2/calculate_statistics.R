library(quantmod)
library(TTR)

# Helper function to calculate statistical mode
get_mode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Self-contained function to load data and compute statistics
calculate_statistics <- function(filename = "portfolio.txt") {
  tickers <- readLines(filename)
  stats_list <- list()
  
  for (ticker in tickers) {
    ticker <- trimws(ticker)
    if (nchar(ticker) > 0) {
      # Automatically download data if it isn't already loaded in R
      if (!exists(ticker)) {
        message(paste("Fetching data for:", ticker))
        getSymbols(ticker, src = "yahoo", auto.assign = TRUE)
      }
      
      stock_data <- get(ticker)
      close_prices <- Cl(stock_data) 
      close_vector <- as.numeric(close_prices[!is.na(close_prices)])
      
      mean_val <- mean(close_vector)
      median_val <- median(close_vector)
      mode_val <- get_mode(round(close_vector, 2))
      sd_val <- sd(close_vector)
      sma_val <- tail(SMA(close_prices, n = 20), 1)
      
      stats_list[[ticker]] <- data.frame(
        Ticker = ticker,
        Mean = mean_val,
        Median = median_val,
        Mode = mode_val,
        StdDev = sd_val,
        Latest_SMA20 = as.numeric(sma_val)
      )
    }
  }
  
  summary_df <- do.call(rbind, stats_list)
  return(summary_df)
}

# Execute the function and view the results
portfolio_stats <- calculate_statistics("portfolio.txt")
print(portfolio_stats)