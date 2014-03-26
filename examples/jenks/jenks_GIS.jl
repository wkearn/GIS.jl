using GIS

include("jenks.jl")

MApop = open_raster("mapop300.tif")


# Use the Jenks algorithm to create classes
jenks_classes = jenks(vec(copy(MApop.data)[MApop.data.>0]),5)


# Find which class each point belongs to
MApopbinned = zeros(Int,size(MApop.data))

for i = 1:5
    MApopbinned += i*(jenks_classes[i].<=MApop.data.<jenks_classes[i+1])
end

# Deal with the maximum which isn't assigned to any bin by the former procedure
index = findmax(MApop.data)[2]
MApopbinned[index] = 5

# Create raster of the binned data

MApopbinnedraster = Raster(C_NULL,MApop.width,MApop.height,MApop.transform,MApop.projection,MApopbinned)

# Display raster

display(MApopbinnedraster)
