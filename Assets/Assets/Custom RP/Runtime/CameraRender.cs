using UnityEngine.Rendering;
using UnityEngine;

public class CameraRender
{
    ScriptableRenderContext context;
    Camera camera;
    const string bufferName = "Render Camera";
    public void Render(ScriptableRenderContext context, Camera camera)
    {
        this.context = context;
        this.camera = camera;
        Setup();
        DrawVisibleGeometry();
        Submit();
        
    }
    void DrawVisibleGeometry()
    {
        context.DrawSkybox(camera);
    }
    void Submit()
    {
        context.Submit();
    }
    void Setup()
    {
        context.SetupCameraProperties(camera);
    }
}