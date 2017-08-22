#################################
## friaR ##
#################################

sauce = "~/personal_projects/friaR/dependencies/env_scripts.R"
##########
## Set ENV
##########
source(sauce,local=TRUE)
loadEnv("friaR")

############
## Clean ENV
############
source(sauce,local=TRUE)
cleanEnv()