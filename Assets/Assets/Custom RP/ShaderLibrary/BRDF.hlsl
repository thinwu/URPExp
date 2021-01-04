#ifndef CUSTOM_BRDF_INCLUDED
#define CUSTOM_BRDF_INCLUDED
#include "Surface.hlsl"
#define MIN_REFLECTIVITY 0.04
struct BRDF
{
    half3 diffuse;
    half3 specular;
    half roughness;
};
half OneMinusReflectivity(half metallic)
{
    float range = 1 - MIN_REFLECTIVITY;
    return range - metallic * range;
}
BRDF GetBRDF(Surface surface)
{
    BRDF brdf;
    half oneMinusReflectivity = OneMinusReflectivity(surface.metallic); //1.0 - surface.metallic;
    brdf.diffuse = surface.color * oneMinusReflectivity;
    brdf.specular = 0.0;
    brdf.roughness = 1.0;
    return brdf;
}

#endif 