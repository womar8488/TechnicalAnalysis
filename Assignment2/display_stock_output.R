# Utility function to display loaded stock data in various formats
display_stock_output <- function(filename = "portfolio.txt") {
  tickers <- readLines(filename)
  
  for (ticker in tickers) {
    ticker <- trimws(ticker)
    if (nchar(ticker) > 0) {
      # Automatically fetch data if it isn't loaded in the environment yet
      if (!exists(ticker)) {
        message(paste("Fetching data for:", ticker))
        getSymbols(ticker, src = "yahoo", auto.assign = TRUE)
      }
      
      cat("\n========================================\n")
      cat("DISPLAY OUTPUT FOR:", ticker, "\n")
      cat("========================================\n")
      
      stock_obj <- get(ticker)
      
      # 1. Show the tail (most recent market entries, like Yahoo Finance view)
      cat("\n--- Recent Market Data (Tail) ---\n")
      print(tail(stock_obj, 5))
      
      # 2. Show statistical summary of the data frame
      cat("\n--- Statistical Summary ---\n")
      print(summary(stock_obj))
    }
  }
}

# Execute the display utility function
display_stock_output("portfolio.txt")
