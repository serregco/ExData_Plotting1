plot1 <- function (fichero) {
  data_file <- file(fichero)
  #cargamos los datos filtrando por los dias 1 y 2 de febrero de 2007
  plots_data <-read.table(text = grep("^[1,2]/2/2007",readLines(data_file),value=TRUE),
                col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),sep=";",header = TRUE)
  
  #generamos el histograma teniendo en cuenta la métrica Global Active Power
  hist(plots_data$Global_active_power, col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power")
  #lo copiamos en un fichero png
  dev.copy(png,file="plot1.png")
  dev.off()
}