#ifndef CUSTOM_LIGHTING_INCLUDED
#define CUSTOM_LIGHTING_INCLUDED
#include "Surface.hlsl"
#include "Light.hlsl"
half3 GetLighting(Surface surface, Light light)
{
    return IncomingLight(surface, light) * surface.color;
}
half3 GetLighting(Surface surface)
{
    half3 color = 0.0;
    for (int i = 0; i < GetDirectionalLightCount(); i++)
    {
        color += GetLighting(surface, GetDirectionalLight(i));
    }
    return color;
}
#endif