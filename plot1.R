## Loading libraries
library (datasets)
library (downloader)
library (ggplot2)
library (graphics)
library (grid)
library (lattice)
library (plyr)
library (reshape2)

projectFolder <- "project"
setwd ("~/")

# If folder does not exist, dir.create is used to create it

if (!file.exists (projectFolder)){
        dir.create (projectFolder)
}

setwd(projectFolder)

## Download the repository: Dataset -->Data for Peer Assessment
if (!file.exists("Source_Classification_Code.rds")||!file.exists("summarySCC_PM25.rds")){
        ## Source file - URL
        URLFile <- "https://d396qusza40orc.cloudfront.net/exdata/data/NEI_data.zip"

        ## Destination file
        destFilezip = "NEI_dataEDA.zip"

        ## Download file
        download (URLFile, destFilezip)

        ## Unzip file
        unzip (destFilezip, overwrite = T)
}
