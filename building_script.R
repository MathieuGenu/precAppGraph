library(usethis)
library(devtools)
library(roxygen2)

use_build_ignore("building_script.R")
use_build_ignore("img")
use_build_ignore("readme.Rmd")
use_gpl3_license("Mathieu Genu")

# import package
cran_package <- c("ggplot2","scales","ggrepel","magrittr")
for(pckg in cran_package){
  use_package(pckg, type="Imports")
}



load_all()
document()
check()


# building_data
load("C:/Users/Mathieu/Documents/Code/R/graphe_approche_precaution/precautionary_approach_script/res/fishing_data.RData")
Herring_ICES <- list(Herring_data = fishing_data,
                     # values from the advice
                     Fpa = 0.30,
                     Bpa = 900000,
                     Flim = 0.34,
                     Blim = 800000
                     )
use_data(Herring_ICES, overwrite = T)
