# Install the R package in this folder

setwd("./")
tryCatch({
  install.packages(file.path("."), repos = NULL, type = "source", INSTALL_opts=c("--no-multiarch"))
}, finally = {})

# Get the database connection properties as set in the Data Node
dbms <- Sys.getenv("DBMS_TYPE")
connectionString <- Sys.getenv("CONNECTION_STRING")
user <- Sys.getenv("DBMS_USERNAME")
pwd <- Sys.getenv("DBMS_PASSWORD")
cdmDatabaseSchema <- Sys.getenv("DBMS_SCHEMA")
resultsDatabaseSchema <- Sys.getenv("RESULT_SCHEMA")
cohortsDatabaseSchema <- Sys.getenv("TARGET_SCHEMA")
cohortTable <- Sys.getenv("COHORT_TARGET_TABLE")
driversPath <- (function(path) if (path == "") NULL else path)( Sys.getenv("JDBC_DRIVER_PATH") )


# Create the connectionDetails 
connectionDetails <- DatabaseConnector::createConnectionDetails(
  dbms = dbms,
  connectionString = connectionString,
  user = user,
  password = pwd,
  pathToDriver = driversPath
)

# Create the output folder
exportFolder <- file.path(getwd(), 'export')
dir.create(exportFolder)

# Code to be executed
nrPersons <- ArachneCustomPackage::getNumberOfPersons(connectionDetails,cdmDatabaseSchema, exportFolder)

# Save the results to the outputFolder
readr::write_csv(nrPersons, file.path(exportFolder, "results.csv"))

# Zip the results
zipName <- file.path(exportFolder, "Results.zip")
#files <- list.files(exportFolder, pattern = ".*\\.csv$")
files <- list.files(exportFolder, pattern = ".*")
oldWd <- setwd(exportFolder)
on.exit(setwd(oldWd), add = TRUE)
DatabaseConnector::createZipFile(zipFile = zipName, files = files)





