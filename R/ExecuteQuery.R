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
getNumberOfPersons <- function (connectionDetails,cdmDatabaseSchema,exportFolder){
  
  # Log execution -----------------------------------------------------------------------------------------------------------------
  ParallelLogger::clearLoggers()
  unlink(file.path(exportFolder, "package-log.txt"))
  
  appenders <- list(ParallelLogger::createConsoleAppender(),
                    ParallelLogger::createFileAppender(layout = ParallelLogger::layoutParallel, 
                                                        fileName = file.path(exportFolder, "package-log.txt")))    
  
  logger <- ParallelLogger::createLogger(name = "arachneCustomPackage",
                                         threshold = "INFO",
                                         appenders = appenders)
  ParallelLogger::registerLogger(logger) 
  
  # Establish folder paths --------------------------------------------------------------------------------------------------------
  
  if (!dir.exists(exportFolder)) {
    dir.create(path = exportFolder, recursive = TRUE)
  }
  
  # Execute Query ---------------------------------------------------------------------------------------------
  
  connection <- DatabaseConnector::connect(connectionDetails = connectionDetails)
  
  sql <- SqlRender::render("select COUNT_BIG(distinct person_id) as count_value from @cdmDatabaseSchema.person;", 
                           cdmDatabaseSchema = cdmDatabaseSchema)
  sql <- SqlRender::translate(sql = sql, targetDialect = connectionDetails$dbms)
  
  result <- DatabaseConnector::querySql(connection = connection, sql = sql, errorReportFile = "getNumberofPersons.sql")
  
}
                             