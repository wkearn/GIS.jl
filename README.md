# JuliaGIS #

A package for the visualization and manipulation of geographic data.

## Concept ##

JuliaGIS provides a frontend for interacting with geographic data in Julia. The backend is provided by [GDAL.jl](https://github.com/wkearn/GDAL.jl) for raster data, the as-yet unwritten OGR.jl wrapper for vector data, and [Images](https://github.com/timholy/Images.jl) for visualization.

## Installation ##

	Pkg.clone("git://github.com/wkearn/GIS.jl")

## Usage ##

	using GIS

allows you to use all of the GIS contained within GDAL, the fictional OGR and any other core GIS packages. Thus `using GIS` allows you to `open_raster("/path/to/raster/file")`.

	display(raster)

converts the raster to a `RasterImage` type and displays the `RasterImage` using [ImageView](https://github.com/timholy/ImageView.jl)

## Todo ##

1. Multiple raster display -- this probably requires some messing with [GDAL.jl](https://github.com/wkearn/GDAL.jl) (and maybe OGR to deal with projections)
2. Multi-band raster support -- once this is added to GDAL.jl, a couple of quick tweaks to `RasterImage` properties will let you display multi-band rasters as RGB images.

