## Shiny Map US MacDonald -- User Guide

This online Shiny application combines Shiny and Leaflet to create a search map to find the MacDonalds around (could generalized to include other dining places).

The usage of the online app is straightforward. The user is required to input a valid zip code (where you are?) and the range (in miles from where you are) that is reachable to you.

In the main panel, there will display a map showing your current location with a marker and all the available MacDonalds near you with circle markers. A table underneath the map, lists all the addresses of the MacDonalds and the miles from you.

The longitude and latitude data for all zip code are downloaded from: 

<https://gist.github.com/erichurst/7882666>.

The longitude and latitude data for all MacDonalds in US is given in the following site: 

<https://fusiontables.google.com/DataSource?docid=1HDRk5AjNoPCShwERz_bjyKVGDapFmQil4hl9eMM>.

The distance between different places given longitude and latitude coordinates are calculated with the help of `spDistsN1` function in `sp` package using great circle distance measure.

The source code is available on the following GitHub repository: 

<https://github.com/bolaik/ShinyMapMacDonald>.