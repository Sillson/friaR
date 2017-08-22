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


############
## Clean ENV
############
cleanEnv()