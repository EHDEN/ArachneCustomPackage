ArachneCustomPackage
===========================================================================================

<img src="https://img.shields.io/badge/Study%20Status-Design%20Finalized-brightgreen.svg" alt="Study Status: Design Finalized">

- Analytics use case(s): **Demo Package**
- Study type: **Clinical Application**
- Tags: **EHDEN**
- Study lead: **Peter Rijnbeek**
- Study lead forums tag: **[Peter Rijnbeek](https://forums.ohdsi.org/u/rijnbeek)**
- Study start date: **TBD**
- Study end date: **TBD**
- Protocol: **TBD**
- Publications: **-**
- Results explorer: **NA**

**Objectives:**
The aim of this study is to demonstrate the creation of a study package that can be executed in ARACHNE Data Node. This package uses Renv to assure the same versions of all R package dependencies are used.

## Package Installation

This section will detail the process for installing the package along with all of the R package dependencies using [renv](https://rstudio.github.io/renv/articles/renv.html). In short, we are using renv to encapsulate the R dependencies for this project and assure they are the same version as intended by the package developer when executing the package in Arachne Data Node.

Start by cloning the R package in an empty folder and open the project in R studio, then run the following commands.

````
install.packages("renv")

projectFolder <- getwd()

#------------------------------------------------------------------
# We want to have the entire contents of the renv R packages local 
# to your project so Arachne Data Node can execute it 
#------------------------------------------------------------------
Sys.setenv("RENV_PATHS_CACHE"=projectFolder)

# Restore the local library (this may take some time):
renv::restore()

Now build the package to add itself in the renv library. 

````

You can now create the Arachne zip in a subfolder called arachne (or change the targetFolder) by using this command:

````
   ArachneCustomPackage::createArachneZip()
````

## Status
Under development do not use.
