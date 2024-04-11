---
title: "temperature Manual"
subtitle: "v.1.0.0"
date: "Last updated: 2024-04-11"
output:
  bookdown::html_document2:
    toc: true
    toc_float: true
    theme: sandstone
    number_sections: false
    df_print: paged
    keep_md: yes
editor_options:
  chunk_output_type: console
  bibliography: citations/references_temperature.bib
link-citations: true
always_allow_html: true
---

# temperature Module

<!-- the following are text references used in captions for LaTeX compatibility -->
(ref:temperature) *temperature*



[![made-with-Markdown](figures/markdownBadge.png)](https://commonmark.org)

<!-- if knitting to pdf remember to add the pandoc_args: ["--extract-media", "."] option to yml in order to get the badge images -->

#### Authors:

Tati Micheletti <tati.micheletti@gmail.com> [aut, cre]
<!-- ideally separate authors with new lines, '\n' not working -->

## Module Overview

### Module summary

The temperature module will run from 2013 to 2032, which are the years for which we have data. 
The module simply (1) downloads data, (2) converts it to a raster, and (3) plots the data.

### Module inputs and parameters

The module requires only a data frame with the following columns: `temperature` (in anumeric form), `years` (year of the data collection in numericform) and coordinates in  latlong system (two columns, `lat` and`long`, indicating latitude and longitude, respectively).
The data for version 1.0.0. is available at: https://zenodo.org/records/10885997/files/temperature.csv

Table \@ref(tab:moduleInputs-temperature) shows the full list of module inputs.

<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>(\#tab:moduleInputs-temperature)(\#tab:moduleInputs-temperature)List of (ref:temperature) input objects and their description.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> objectName </th>
   <th style="text-align:left;"> objectClass </th>
   <th style="text-align:left;"> desc </th>
   <th style="text-align:left;"> sourceURL </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> tempt </td>
   <td style="text-align:left;"> data.frame </td>
   <td style="text-align:left;"> data frame with the following columns: `temperature` (in anumeric form), `years` (year of the data collection in numericform) and coordinates in latlong system (two columns, `lat` and`long`, indicating latitude and longitude, respectively).In this example, we use the data v.2.0.0 </td>
   <td style="text-align:left;"> https://zenodo.org/records/10877463/files/temperature.csv </td>
  </tr>
</tbody>
</table>

Here is a summary of parameters (Table \@ref(tab:moduleParams-temperature))

<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>(\#tab:moduleParams-temperature)(\#tab:moduleParams-temperature)List of (ref:temperature) parameters and their description.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> paramName </th>
   <th style="text-align:left;"> paramClass </th>
   <th style="text-align:left;"> default </th>
   <th style="text-align:left;"> min </th>
   <th style="text-align:left;"> max </th>
   <th style="text-align:left;"> paramDesc </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> .plotInitialTime </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> Describes the simulation time at which the first plot event should occur. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> .plotInterval </td>
   <td style="text-align:left;"> numeric </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Describes the simulation time interval between plot events. </td>
  </tr>
  <tr>
   <td style="text-align:left;"> areaName </td>
   <td style="text-align:left;"> character </td>
   <td style="text-align:left;"> Riparian.... </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> Name for the study area used </td>
  </tr>
</tbody>
</table>

### Events

The temperature module will run from 2013 to 2032, which are the years for which we have data AND temperature forecasts. Before the simulation, the module will also download data, and then confirm that this data has the expected format. It will convert the table of coordinates, years, and temperatures to a raster, and append it to a list that will contain rasters for all the years. The module will then plot the raster created. This will also be done for every year data is available.

### Module outputs

Description of the module outputs (Table \@ref(tab:moduleOutputs-temperature)).

<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>(\#tab:moduleOutputs-temperature)(\#tab:moduleOutputs-temperature)List of (ref:temperature) outputs and their description.</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> objectName </th>
   <th style="text-align:left;"> objectClass </th>
   <th style="text-align:left;"> desc </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> tempRas </td>
   <td style="text-align:left;"> SpatRaster </td>
   <td style="text-align:left;"> A raster object of spatially explicit temperature data for a given year </td>
  </tr>
</tbody>
</table>

### Links to other modules

This module is stand-alone, but has been created to be ran with the module `speciesAbundance` 
and `speciesAbundTempLM` as a way of demonstrating `SpaDES`.

### Getting help

Detailed module creation and functioning can be found at `https://html-preview.github.io/?url=https://github.com/tati-micheletti/EFI_webinar/blob/main/HandsOn.html`

- Please use GitHub issues (https://github.com/tati-micheletti/temperature/issues/new) 
if you encounter any problems in using this module.
