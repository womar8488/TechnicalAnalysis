# Load the required quantmod package
library(quantmod)

# Define the function to read portfolio.txt and load stock data
load_stock_data <- function(filename = "portfolio.txt") {
  # Read the stock tickers from the text file line by line
  tickers <- readLines(filename)
  
  # Loop through each ticker symbol and fetch data
  for (ticker in tickers) {
    ticker <- trimws(ticker) # Remove any extra whitespace
    if (nchar(ticker) > 0) { # Ensure line isn't empty
      message(paste("Loading data for:", ticker))
      getSymbols(ticker, src = "yahoo", auto.assign = TRUE)
    }
  }
}

# Execute the function
load_stock_data("portfolio.txt")