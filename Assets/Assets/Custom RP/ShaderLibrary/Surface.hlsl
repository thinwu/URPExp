#ifndef CUSTOM_SURFACE_INCLUDED
#define CUSTOM_SURFACE_INCLUDED
struct Surface
{
    half3 normal;
    half3 viewDirection;
    half alpha;
    half3 color;
    half metallic;
    half smoothness;
};

#endif