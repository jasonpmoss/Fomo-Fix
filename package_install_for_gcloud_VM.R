#recommenderlabs requires packages that are not compatible with the Debian virtual machine r version. 
# So, we need to install older versions. This code does that.

install.packages("devtools")
require(devtools)
install_version("arules", version = "1.5-2", repos = "http://cran.us.r-project.org")
install_version("proxy", version = "0.4-17", repos = "http://cran.us.r-project.org")
install.packages("recommenderlab", dependencies = FALSE)

#other packages you may need
install.packages("bigrquery")
install.packages("magrittr")
install.packages("dplyr")
install.packages("plyr")
install.packages("data.table")
install.packages("reshape2")
install.packages("leaflet")
install.packages("future")
install.packages("purrr")
install.packages("ggplot2")
