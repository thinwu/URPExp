// BRDF => bidirectional reflectance distribution function
#ifndef CUSTOM_BRDF_INCLUDED
#define CUSTOM_BRDF_INCLUDED
#include "Surface.hlsl"
#include "Light.hlsl"
#include "Common.hlsl"
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
BRDF GetBRDF(Surface surface, bool applyAlphaToDiffuse = false)
{
    BRDF brdf;
    half oneMinusReflectivity = OneMinusReflectivity(surface.metallic); //1.0 - surface.metallic;
    brdf.diffuse = surface.color * oneMinusReflectivity;
    if (applyAlphaToDiffuse)
    {
        brdf.diffuse *= surface.alpha;
    }
    brdf.specular = lerp(MIN_REFLECTIVITY, surface.color, surface.metallic);
    half perceptualRoughness = PerceptualSmoothnessToPerceptualRoughness(surface.smoothness);
    brdf.roughness = PerceptualRoughnessToRoughness(perceptualRoughness);
    return brdf;
}
/*
* https://catlikecoding.com/unity/tutorials/custom-srp/directional-lights/
* Specular Strength
*/
half SpecularStrengh(Surface surface, BRDF brdf, Light light)
{
    half3 h = SafeNormalize(light.direction + surface.viewDirection);
    half nh2 = Square(saturate(dot(surface.normal, h)));
    half lh2 = Square(saturate(dot(light.direction, h)));
    half r2 = Square(brdf.roughness);
    half d2 = Square(nh2 * (r2 - 1.0) + 1.00001);
    half normalization = brdf.roughness * 4.0 + 2.0;
    return r2 / (d2 - max(0.1, lh2) * normalization);
}
half3 DirectBRDF(Surface surface, BRDF brdf, Light light)
{
    return SpecularStrengh(surface, brdf, light) * brdf.specular + brdf.diffuse;
}
#endif 