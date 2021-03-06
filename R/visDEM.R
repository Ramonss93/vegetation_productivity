visDEM <- function(dem, zlevs.conts = seq(1000, 5500, 500), 
                   labels = c(1000, "", 2000, "", 3000, "", 4000, "", 5000, ""), 
                   cex = 1.8, col = "grey50", labcex = 1, ...) {

  ## packages
  library(raster)
  library(lattice)
  
  ## functions
  source("R/panel.smoothconts.R")
  
  ## import dem (if necessary)
  if (is.character(dem)) {
    rst_dem <- raster(dem)
  } else if (class(dem) == "RasterLayer") {
    rst_dem <- dem
  } else {
    stop("Please supply a 'RasterLayer' or a valid file path.")
  }
  
  ## extract coordinates and flip dem  
  rst_dem_flipped <- flip(rst_dem, "y")
  x <- coordinates(rst_dem_flipped)[, 1]
  y <- coordinates(rst_dem_flipped)[, 2]
  z <- rst_dem_flipped[]
  
  ## create figure
  levelplot(z ~ x * y, colorkey = FALSE,  
            panel = function(...) {
              panel.smoothconts(zlevs.conts = zlevs.conts, labels = labels, 
                                col = col, cex = cex, labcex = labcex, ...)
            })
  
}