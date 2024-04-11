## Everything in this file and any files in the R directory are sourced during `simInit()`;
## all functions and objects are put into the `simList`.
## To use objects, use `sim$xxx` (they are globally available to all modules).
## Functions can be used inside any function that was sourced in this module;
## they are namespaced to the module, just like functions in R packages.
## If exact location is required, functions will be: `sim$.mods$<moduleName>$FunctionName`.
defineModule(sim, list(
  name = "temperature",
  description = paste0("This is a simple example module on how SpaDES work. It uses made up data",
                       "and is partially based on the example publised by Barros et al., 2022",
                       "(https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/2041-210X.14034)"),
  keywords = c("example", "SpaDES tutorial"),
  authors = structure(list(list(given = "Tati", family = "Micheletti", role = c("aut", "cre"), 
                                email = "tati.micheletti@gmail.com", comment = NULL)), 
                      class = "person"),
  childModules = character(0),
  version = list(temperature = "1.0.0"),
  timeframe = as.POSIXlt(c(2013, 2032)),
  timeunit = "year",
  citation = list("citation.bib"),
  documentation = list("NEWS.md", "README.md", "temperature.Rmd"),
  reqdPkgs = list("SpaDES.core (>= 2.0.3)", "terra", "reproducible", "ggplot2"),
  parameters = bindrows(
    defineParameter(".plotInitialTime", "numeric", start(sim), start(sim), end(sim),
                    "Describes the simulation time at which the first plot event should occur."),
    defineParameter(".plotInterval", "numeric", 10, NA, NA,
                    "Describes the simulation time interval between plot events."),
    defineParameter("areaName", "character", "Riparian_Woodland_Reserve", NA, NA,
                    "Name for the study area used")
  ),
  inputObjects = bindrows(
    expectsInput(objectName = "tempt", 
                 objectClass = "data.frame", 
                 desc = paste0("data frame with the following columns: `temperature` (in a",
                               "numeric form), `years` (year of the data collection in numeric",
                               "form) and coordinates in  latlong system (two columns, `lat` and",
                               "`long`, indicating latitude and longitude, respectively).",
                               "In this example, we use the data v.2.0.0"), 
                 sourceURL = "https://zenodo.org/records/10877463/files/temperature.csv")
  ),
  outputObjects = bindrows(
    createsOutput(objectName = "tempRas", objectClass = "SpatRaster", 
                  desc = "A raster object of spatially explicit temperature data for a given year")
  )
))

## event types
#   - type `init` is required for initialization

doEvent.temperature = function(sim, eventTime, eventType) {
  switch(
    eventType,
    init = {
      ### check for more detailed object dependencies:
      if (!is(sim$tempt, "data.table"))
        sim$tempt <- data.table(sim$tempt)
      
      if (!all("temperature" %in% names(sim$tempt), 
               "years" %in% names(sim$tempt),
               "lat" %in% names(sim$tempt),
               "long" %in% names(sim$tempt)))
        stop("Please revise the column names in the temperature data")
      
      # schedule future event(s)
      sim <- scheduleEvent(sim, start(sim), "temperature", "dataToRaster")
      sim <- scheduleEvent(sim, P(sim)$.plotInitialTime, "temperature", "plotting")
    },
    dataToRaster = {
      # do stuff for this event
      sim$tempRas <- convertToRaster(dataSet = sim$tempt, 
                                     currentTime = time(sim),
                                     nameRaster = paste0("Temperature: ", time(sim)))
      # schedule future event(s)
      sim <- scheduleEvent(sim, time(sim) + 1, "temperature", "dataToRaster")
    },
    plotting = {
      # do stuff for this event
      terra::plot(sim$tempRas, main = paste0("Temperature: ", time(sim)))

      # schedule future event(s)
      sim <- scheduleEvent(sim, time(sim) + P(sim)$.plotInterval, "temperature", "plotting")
      
      # ! ----- STOP EDITING ----- ! #
    },
    warning(paste("Undefined event type: \'", current(sim)[1, "eventType", with = FALSE],
                  "\' in module \'", current(sim)[1, "moduleName", with = FALSE], "\'", sep = ""))
  )
  return(invisible(sim))
}
.inputObjects <- function(sim) {
  # Any code written here will be run during the simInit for the purpose of creating
  # any objects required by this module and identified in the inputObjects element of defineModule.
  # This is useful if there is something required before simulation to produce the module
  # object dependencies, including such things as downloading default datasets, e.g.,
  # downloadData("LCC2005", modulePath(sim)).
  # Nothing should be created here that does not create a named object in inputObjects.
  # Any other initiation procedures should be put in "init" eventType of the doEvent function.
  # Note: the module developer can check if an object is 'suppliedElsewhere' to
  # selectively skip unnecessary steps because the user has provided those inputObjects in the
  # simInit call, or another module will supply or has supplied it. e.g.,
  # if (!suppliedElsewhere('defaultColor', sim)) {
  #   sim$map <- Cache(prepInputs, extractURL('map')) # download, extract, load file from url in sourceURL
  # }
  
  #cacheTags <- c(currentModule(sim), "function:.inputObjects") ## uncomment this if Cache is being used
  dPath <- asPath(getOption("reproducible.destinationPath", dataPath(sim)), 1)
  message(currentModule(sim), ": using dataPath '", dPath, "'.")
  
  # ! ----- EDIT BELOW ----- ! #
  if (!suppliedElsewhere(object = "tempt", sim = sim)) {
    sim$tempt <- prepInputs(url = extractURL("tempt"),
                            targetFile = "temperature.csv",
                            destinationPath = dPath,
                            fun = "read.csv",
                            header = TRUE)
    warning(paste0("tempt was not supplied. Using example data"), immediate. = TRUE)
  }
  # ! ----- STOP EDITING ----- ! #
  return(invisible(sim))
}
