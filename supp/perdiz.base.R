# download most recent software version
#devtools::install_github("geomorphR/geomorph", ref = "Stable", build_vignettes = TRUE)
#devtools::install_github("mlcollyer/RRPP")

# load analysis packages
library(here)
library(StereoMorph)
library(geomorph)
library(ggplot2)
library(dplyr)
library(wesanderson)

# read shape data and define number of sLMs
shapes <- readShapes("shapes")

# read shape data and define number of sLMs
curves <- readShapes("shapes/554.txt")$curves.scaled

curves_sub <- list()
curves_sub[['curveLM07']] <- pointsAtEvenSpacing(x = curves[['curveLM07']], n=10)
curves_sub[['curveLM08']] <- pointsAtEvenSpacing(x = curves[['curveLM08']], n=3)
curves_sub[['curveLM09']] <- pointsAtEvenSpacing(x = curves[['curveLM09']], n=5)
curves_sub[['curveLM10']] <- pointsAtEvenSpacing(x = curves[['curveLM10']], n=5)
curves_sub[['curveLM11']] <- pointsAtEvenSpacing(x = curves[['curveLM11']], n=3)
curves_sub[['curveLM12']] <- pointsAtEvenSpacing(x = curves[['curveLM12']], n=10)

# subset basal landmarks/semilandmarks
base <- curves$landmarks[2:6,15:22,,]
shapesGM <- readland.shapes(shapes, nCurvePts = c(10,3,5,5,3,10))
base <- shapesGM$landmarks[2:6,15:22,,]