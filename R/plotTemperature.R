plotTemperature <- function(temperatureData, yearsToPlot){
  Sys.sleep(1.2) # To ensure we will see the results from the previous plot
  dataplot <- temperatureData[years %in% yearsToPlot,]
  tempData <- Copy(dataplot)
  tempData[, years := as.factor(years)]
  tempData[, averageYear := mean(temperature), by = "years"]
  pa <- ggplot(data = tempData, aes(x = temperature, group=years, color=years, fill = years)) +
    geom_histogram(binwidth=0.5) +
    facet_grid(years ~ .) +
    geom_vline(data = unique(tempData[, c("years", "averageYear")]),
               aes(xintercept = averageYear),
               linetype="dashed", color = "black") +
    theme(legend.position = "none")
  print(pa)
  Sys.sleep(1.2) # To ensure we will see the results from the previous plot
  return(pa)
}
