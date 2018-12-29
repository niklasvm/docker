# rstudio

This dockerfile can be used to build a data-science focussed image.

Starts with a versioned rocker/verse image and adds the following installations:

  * pip
  * pre-release rstudio-server
  * aws cli
  * h2o
  * sparklyr and spark
  * keras
  * shiny

Additionally it
  * copies over an `.Renviron` containing any necessary credentials that need to be stored outside of the code
  * copies over `id_rsa` your github private to configure using rstudio's git integration when in a project

Build arguments:
  * R_VERSION - version of R to be based on
  * RSTUDIO_VERSION - version of RStudio Server to installs
  * SPARK_VERSION - version of spark to install
  * BUILD_DATE - snapshot date to use for CRAN repo
