library(here)
library(StereoMorph)
library(geomorph)
library(ggplot2)
library(dplyr)
library(wesanderson)

# read shape data and define number of sLMs
shapes <- readShapes("shapes")
shapesGM <- readland.shapes(shapes, nCurvePts = c(10,3,5,5,3,10))

# read qualitative data
qdata <- read.csv("qdata.csv",
                  header = TRUE,
                  row.names = 1)

# gpa
Y.gpa <- gpagen(shapesGM, print.progress = FALSE)
plot(Y.gpa)

# dataframe
gdf <- geomorph.data.frame(shape = Y.gpa$coords,
                           size = Y.gpa$Csize,
                           raw.mat = qdata$raw.mat)

# add centroid size to qdata
qdata$csz <- Y.gpa$Csize

# attributes
csz <- qdata$csz
raw.mat <- qdata$raw.mat

# palette
pal = wes_palette("Moonrise2")

# boxplot of Perdiz arrow points by raw.mat
csz.temp <- ggplot(qdata, aes(x = raw.mat, y = csz, color = raw.mat)) +
  geom_boxplot() +
  geom_dotplot(binaxis = 'y', stackdir = 'center', dotsize = 0.3) +
  scale_color_manual(values = pal) +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(x = 'Raw Material', y = 'Centroid Size')

# render plot
csz.temp

# pca
pca <- gm.prcomp(Y.gpa$coords)
summary(pca)

# set plot parameters
pch.gps <- c(15:17)[as.factor(raw.mat)]
col.gps <- pal[as.factor(raw.mat)]
col.hull <- c("#C27D38","#798E87","#CCC591")

# pca plot
pc.plot <- plot(pca,
                asp = 1,
                pch = pch.gps,
                col = col.gps)
shapeHulls(pc.plot,
           groups = raw.mat,
           group.cols = col.hull)

# plot x/y maxima/minima
# x - minima
mean.shape <- mshape(Y.gpa$coords)
plotRefToTarget(pca$shapes$shapes.comp1$min, 
                mean.shape)

# x - maxima
plotRefToTarget(pca$shapes$shapes.comp1$max, 
                mean.shape)

# y - minima
plotRefToTarget(pca$shapes$shapes.comp2$min, 
                mean.shape)

# y - maxima
plotRefToTarget(pca$shapes$shapes.comp2$max, 
                mean.shape)
