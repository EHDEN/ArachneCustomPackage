# @file ArachneCustomPackage
#
# Copyright 2020 European Health Data and Evidence Network (EHDEN)
#
# This file is part of CatalogueExport
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# @author European Health Data and Evidence Network
# @author Peter Rijnbeek

#' @export
createArachneZip <- function (targetFolder=file.path(getwd(),"arachne")){
  
  # Copy all to targetFolder
  dir.create(targetFolder)
  arachneFile <- system.file("", "Arachne.R", package = "ArachneCustomPackage")
  file.copy(arachneFile, targetFolder)
  file.copy(file.path(getwd(),"renv.lock"), targetFolder)
  file.copy(file.path(getwd(),"renv"), targetFolder, recursive = TRUE)
  
  
  # Zip the results
  zipName <- file.path(targetFolder, "Arachne Package.zip")
  #files <- list.files(exportFolder, pattern = ".*\\.csv$")
  files <- list.files(targetFolder, pattern = ".*")
  oldWd <- setwd(targetFolder)
  on.exit(setwd(oldWd), add = TRUE)
  DatabaseConnector::createZipFile(zipFile = zipName, files = files)
  
  # Clean up
  unlink(file.path(targetFolder,"renv"),recursive = TRUE)
  unlink(file.path(targetFolder,"renv.lock"))
  unlink(file.path(targetFolder,"Arachne.R"))
}  


