﻿#ifndef CUSTOM_UNLIT_PASS_INCLUDED
#define CUSTOM_UNLIT_PASS_INCLUDED
#include "../ShaderLibrary/Common.hlsl"

UNITY_INSTANCING_BUFFER_START(UnityPerMaterial)
    UNITY_DEFINE_INSTANCED_PROP(half4, _BaseColor)
UNITY_INSTANCING_BUFFER_END(UnityPerMaterial)

struct Attributes
{
    half3 positionOS : POSITION;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings
{
    half4 positionCS : SV_Position;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

Varyings UnlitPassVertex(Attributes input)
{
    Varyings output;
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input, output);
    half3 positionWS = TransformObjectToWorld(input.positionOS);
    output.positionCS = TransformWorldToHClip(positionWS);
    return output;
}

half4 UnlitPassFragment(Varyings input) : SV_Target
{
    UNITY_SETUP_INSTANCE_ID(input);
    return UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _BaseColor);
}
#endif