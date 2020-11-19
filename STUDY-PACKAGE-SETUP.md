Setup of the study package
===========================================================================================

The following steps will detail how to set up the package using [renv](https://rstudio.github.io/renv/articles/renv.html) and how to execute the study.

# Package Installation

This section will detail the process for installing the package along with all of the R package dependencies using [renv](https://rstudio.github.io/renv/articles/renv.html). In short, we are using renv to encapsulate the R dependencies for this project and assure they are the same version as intended by the package developer when executing the package in Arachne Data Node.

The script below is an example to use for setting up your environment. There are some items to consider before moving ahead with the installation.

## Package setup considerations

Since this package should be able to run in an environment without Internet access, we set the `RENV_PATHS_CACHE` to the `projectRootFolder` so that you can copy the contents of the `projectRootFolder` to the machine with access to your CDM to run the study. Additionally, you will want to make sure you download the `renv.lock` file from the computer with Internet access.

## Package setup steps

The setup script below is used to install the  package. You will need to modify this setup script as follows:

- Set the `projectRootFolder` to the current folder so all the dependencies are in a subfolder of the study package
    - It will hold the R depdencies in subfolders in this directory.
    - It should be used to hold the output of running the study package.
- If you need to change the default location where `renv` will install the R package dependencies, uncomment out the line: `Sys.setenv("RENV_PATHS_ROOT"="E:\renv")` and replace `"E:\renv"` with your directory of choice.
- If you plan to run the package in an environment where there is no Internet access, uncomment out the line: `Sys.setenv("RENV_PATHS_CACHE"=projectFolder)`. This will ensure that all of the R package dependencies are copied to the `projectRootFolder`.

Then execute the script as shown below:

````
#------------------------------------------------------------------
# INITIAL PROJECT SETUP ---------------------------------------
#------------------------------------------------------------------
# This initial setup will ensure that you have all required
# R packages installed for use with the ScyllaCharacterization
# package. If you are running this in an environment where 
# there is no access to the Internet please see the sections
# below marked "offline setup step".
#------------------------------------------------------------------
#------------------------------------------------------------------
install.packages("renv")

projectFolder <- "E:/ArachneCustomPackage"
setwd(projectFolder)

# Download the lock file:
download.file("https://raw.githubusercontent.com/ohdsi-studies/ScyllaCharacterization/master/renv.lock", "renv.lock")
#Sys.setenv("BINPREF"="E:/R/Rtools/mingw_$(WIN)/bin/")

#------------------------------------------------------------------
# OPTIONAL: If you want to change where renv stores the 
# R packages you can specify the RENV_PATHS_ROOT. Please
# refer to https://rstudio.github.io/renv/articles/renv.html#cache
# for more details
#------------------------------------------------------------------
#Sys.setenv("RENV_PATHS_ROOT"="E:\renv")

#------------------------------------------------------------------
# OFFLINE SETUP STEP: If you want to have the entire contents of
# the renv R packages local to your project so that you may copy
# it to another computer, please uncomment the line below and
# specify the RENV_PATHS_CACHE location which should be your project
# folder.
#------------------------------------------------------------------
Sys.setenv("RENV_PATHS_CACHE"=projectFolder)

# Build the local library:
renv::init()

# When not in RStudio, you'll need to restart R now
library(ArachneCustomPackage)

# -------------------------------------------------------------
# END Initial Project Setup
# -------------------------------------------------------------
````

You will see the following message the first time you run `renv::init()`: 

````
> renv::init()

Welcome to renv!

It looks like this is your first time using renv. This is a one-time message,
briefly describing some of renv's functionality.

renv maintains a local cache of data on the filesystem, located at:

  - "E:/renv"

This path can be customized: please see the documentation in `?renv::paths`.

renv will also write to files within the active project folder, including:

  - A folder 'renv' in the project directory, and
  - A lockfile called 'renv.lock' in the project directory.

In particular, projects using renv will normally use a private, per-project
R library, in which new packages will be installed. This project library is
isolated from other R libraries on your system.

In addition, renv will update files within your project directory, including:

  - .gitignore
  - .Rbuildignore
  - .Rprofile

Please read the introduction vignette with `vignette("renv")` for more information.
You can also browse the package documentation online at https://rstudio.github.io/renv.
````

You can safely continue by pressing 'y' after this prompt since the renv.lock file is downloaded from the **ScyllaCharacterization** GitHub code repository. Once the installation is complete, you may need to restart R (if you are working outside of RStudio) and you should see this message:

````
Project 'E:/ArachneCustomPackage' loaded. [renv 0.11.0]
````

Now the study package is setup and can be shared in ARACHNE! See the [study execution guide](STUDY-EXECUTION.md) for steps to run the package.

