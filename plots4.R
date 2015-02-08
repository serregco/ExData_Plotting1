plot4 <- function (fichero) {
  data_file <- file(fichero)
  #cargamos los datos filtrando por los dias 1 y 2 de febrero de 2007
  plots_data <-read.table(text = grep("^[1,2]/2/2007",readLines(data_file),value=TRUE),
                          col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                                        "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                          sep=";",header = TRUE,na.strings = "?")
  
  #creamos una variable datetime para llegar al nivel de fecha/hora del grafico

  plots_data$DateTime <- as.POSIXct(paste(as.Date(plots_data$Date, format="%d/%m/%Y"),plots_data$Time))
  
  #generamos el grafico
  par(mfrow = c(2,2))
  with(plots_data, {
    plot(Global_active_power ~ DateTime, type="l",ylab="Global Active Power",xlab="")
    plot(Voltage ~ DateTime, type="l",ylab="Voltage",xlab="datetime")
    plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering", xlab="")
    lines(Sub_metering_2 ~ DateTime, col = "red")
    lines(Sub_metering_3 ~ DateTime, col = "blue")
    legend("topright",pch = 1, cex=0.5,col=c("black","red","blue"), legend =  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ DateTime, type="l",xlab="datetime")
  })
  dev.copy(png,file="plot4.png")
  dev.off()
}