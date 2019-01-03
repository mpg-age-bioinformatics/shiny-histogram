.libPaths("/srv/shiny-server/histogram/libs")

if(!require(futile.logger)){
  install.packages("futile.logger", dependencies = TRUE)
  library(futile.logger)
}
  
if(!require(xlsx)){
  install.packages("xlsx", dependencies = TRUE)
  library(xlsx)
}

quit(save="no")

# App summary

# read file

D <- read.xlsx(inFile$datapath, sheetIndex = 1, header = input$header)

# or

D <- read.csv(inFile$datapath, header = input$header, sep = filetype)

plot.data.tmp <- D[['<input$column>']]
plot.data.tmp<-plot.data.tmp[!is.na(plot.data.tmp)]
plot.data.tmp<-as.numeric(plot.data.tmp)

HT<-hist(plot.data.tmp,
         main=input$title,
         xlab='<plot.xlabel()>',
         border="black",
         col="gray",
         las=1, # Rotate the labels on the y axis by adding “las = 1” as an argument. las can be 0, 1, 2 or 3.
         breaks='<plot.breaks()>', # number of breakpoints
         prob = '<input$probability>',
         lwd = '<input$linewidth>',
         xlim=c('<xlow>','<xhigh>'),
         ylim=c('<ylow>','<yhigh>')) 

# if probability and density

lines(density(plot.data.tmp), lwd = '<input$linewidth>') 