# The double call to using GDAL and other GIS packages here is necessary 
# to push the high-level API functions provided by those packages into Main
# See DataFrames for precedent
using GDAL

module GIS

using Images, ImageView
using GDAL


include("display.jl")

export display

end
