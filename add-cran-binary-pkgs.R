# Copyright (c) 2018 Dirk Schumacher, Noam Ross, Rich FitzJohn
# Copyright (c) 2024 Jinhwan Kim

#!/usr/bin/env Rscript

# Script to find dependencies of a pkg list, download binaries and put them
# In the standalone R library.

library(automagic)

options(repos = "https://cloud.r-project.org")

cran_pkgs <- setdiff(unique(c(
  "shiny",
  automagic::get_dependent_packages("shiny")
)), "automagic")

# if you want manually add cran packages, use below code
# cran_pkgs <- c(cran_pkgs, "MANUALPACKAGE")

install_bins <- function(cran_pkgs, library_path, type, decompress,
                         remove_dirs = c("help", "doc", "tests", "html",
                                         "include", "unitTests",
                                         file.path("libs", "*dSYM"))) {
  
  installed <- list.files(library_path)
  
  # use below code if you want to update R packages with recent version which is already installed.
  # installed <- c()
  
  cran_to_install <- sort(setdiff(
    unique(unlist(
      c(cran_pkgs,
        tools::package_dependencies(cran_pkgs, recursive=TRUE,
                                    which= c("Depends", "Imports", "LinkingTo"))))),
    installed))
  if(!length(cran_to_install)) {
    message("No packages to install")
  } else {
    td <- tempdir()
    downloaded <- download.packages(cran_to_install, destdir = td, type=type)
    apply(downloaded, 1, function(x) decompress(x[2], exdir = library_path))
    unlink(downloaded[,2])
  }
  z <- lapply(list.dirs(library_path, full.names = TRUE, recursive = FALSE), 
              function(x) {
                unlink(file.path(x, remove_dirs), force=TRUE, recursive=TRUE)
              })
  invisible(NULL)
}

install_bins(cran_pkgs = cran_pkgs, library_path = file.path("r-win", "library"),
               type = "win.binary", decompress = unzip)

