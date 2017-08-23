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

eval_as_var <- function(str) {
  eval(parse(text=str))
}

for ( stock in stock_list ) {
  # Get stock data from feature list
  getSymbols(stock, from='2015-01-01', to='2017-08-21')
  # We only care about the close price series
  assign(stock, eval_as_var(stock)[,4])
  # Compute logarithmic returns of the stock for the ARIMA model.
  # We want to forecast log returns and not stock prices
  assign(stock, diff(log(eval_as_var(stock)),lag=1))
  assign(stock, eval_as_var(stock)[!is.na(eval_as_var(stock))])
}


############
## Clean ENV
############
cleanEnv()
