#ifndef CUSTOM_LIGHTING_INCLUDED
#define CUSTOM_LIGHTING_INCLUDED
#include "Surface.hlsl"
#include "BRDF.hlsl"
#include "Light.hlsl"
half3 GetLighting(Surface surface,BRDF brdf, Light light)
{
    return IncomingLight(surface, light) * DirectBRDF(surface, brdf, light);
}
half3 GetLighting(Surface surface, BRDF brdf)
{
    half3 color = 0.0;
    for (int i = 0; i < GetDirectionalLightCount(); i++)
    {
        color += GetLighting(surface, brdf, GetDirectionalLight(i));
    }
    return color;
}
#endif