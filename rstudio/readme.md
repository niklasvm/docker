# rstudio

This dockerfile can be used to build a data-science focussed image.

Starts with a versioned `rocker/verse` image and adds the following installations:

  * pip
  * pre-release rstudio-server
  * aws cli
  * h2o
  * sparklyr and spark
  * keras
  * shiny

Additionally it:
  * copies over an `.Renviron` containing any necessary credentials that need to be stored outside of the code
  * copies over `id_rsa` your github private to configure using rstudio's git integration when in a project

Build arguments:
  * `R_VERSION` - version of R to be based on. defaults to `3.5.1`
  * `RSTUDIO_VERSION` - version of RStudio Server to installs. defaults to `1.2.1206`
  * `SPARK_VERSION` - version of spark to install. defaults to `2.4.0`
  * `BUILD_DATE` - snapshot date to use for CRAN repo. defaults to `2018-12-28`
