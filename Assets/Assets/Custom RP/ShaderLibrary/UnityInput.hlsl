#ifndef CUSTOM_UNITY_INPUT_INCLUDED
#define CUSTOM_UNITY_INPUT_INCLUDED
CBUFFER_START(UnityPerDraw)
half4x4 unity_ObjectToWorld;
half4x4 unity_WorldToObject;
half4 unity_LODFade;
half4x4 unity_MatrixVP;
half4x4 unity_MatrixV;
half4x4 glstate_matrix_projection;

real4 unity_WorldTransformParams;
CBUFFER_END
#endif