#################################
## friaR ##
#################################

##########
## Set ENV
##########

directory <- list.dirs(path="~/personal_projects/friaR/dependencies/", full.names = T)
files = list.files(directory)
for ( file in files ) { source(paste0(directory, file), local=TRUE)}

loadEnv("friaR")

# Doing a lot of evaluating strings as variables
eval_as_var <- function(str) {
  eval(parse(text=str))
}

# Yesterday's date
yesterday <- format(Sys.Date()-1, "%Y-%m-%d")

for ( stock in stock_list ) {
  # Get stock data from feature list from start of 2015 to yesterday
  getSymbols(stock, from='2015-01-01', to=yesterday)
  # We only care about the close price series
  assign(stock, eval_as_var(stock)[,4])
  # Compute logarithmic returns of the stock for the ARIMA model.
  # We want to forecast log returns and not stock prices
  assign(stock, diff(log(eval_as_var(stock)),lag=1))
  assign(stock, eval_as_var(stock)[!is.na(eval_as_var(stock))])
  # Evaluate stock and remove if non-stationary
  print(paste("Evaluating stock with Augmented Dickey-Fuller Test -- ", stock))
  evaluation <- adf.test(eval_as_var(stock))
  
  # Remove stock from the list if non-stationary
  if (evaluation[3] != "stationary") {
    stock_list <<- stock_list[stock_list != stock]
  }
}

for ( stock in stock_list ) {
  # Split the dataset into testing and training parts
  breakpoint = floor(nrow(stock)*(2.9/3))
  # Apply ACF and PACF f(x)
  par(mfrow = c(1,1))
  acf.stock = acf(stock[c(1:breakpoint),], main='ACF Plot', lag.max=100)
  pacf.stock = pacf(stock[c(1:breakpoint),], main='PACF Plot', lag.max=100)
  
}


############
## Clean ENV
############
cleanEnv()
