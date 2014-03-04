import ImageView.display

type RasterImage{T,N,A<:AbstractArray} <: AbstractImageDirect{T,N}
    data::A
    properties::Dict
end

RasterImage(data::AbstractArray,props::Dict) = RasterImage{eltype(data),ndims(data),typeof(data)}(data,props)
RasterImage(raster::Raster) = RasterImage{eltype(raster.data),ndims(raster.data),typeof(raster.data)}(raster.data,["limits"=>(minimum(raster.data),maximum(raster.data)),"colorspace"=>"Gray","spatialorder"=>["y","x"],"transform"=>raster.transform,"projection"=>raster.projection])

display(raster::Raster) = display(RasterImage(raster),pixelspacing=[1,1])
