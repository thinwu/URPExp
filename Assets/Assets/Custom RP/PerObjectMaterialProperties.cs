using UnityEngine;

[DisallowMultipleComponent]
public class PerObjectMaterialProperties : MonoBehaviour
{
    static int baseColorId = Shader.PropertyToID("_BaseColor");
    static int srcBlendId = Shader.PropertyToID("_SrcBlend");
    static int dstBlendId = Shader.PropertyToID("_DstBlend");
    static int zWriteId = Shader.PropertyToID("_ZWrite");
    //static int baseMapId = Shader.PropertyToID("_BaseMap");
    static int cutoffId = Shader.PropertyToID("_Cutoff");



    [SerializeField]
    Color baseColor = Color.white;
    //[SerializeField]
    //UnityEngine.Rendering.BlendMode srcBlend = UnityEngine.Rendering.BlendMode.One;
    //[SerializeField]
    //UnityEngine.Rendering.BlendMode dstBlend = UnityEngine.Rendering.BlendMode.Zero;
    //[SerializeField]
    //OnOff zWrite = OnOff.On;
    [SerializeField]
    [Range(0f, 1f)]
    float cutoff = 0.5f;

    static MaterialPropertyBlock block;
    private void OnValidate()
    {
        if(block == null)
        {
            block = new MaterialPropertyBlock();
        }
        
        block.SetColor(baseColorId, baseColor);
        //block.SetTexture(baseMapId, baseMap);
        //block.SetFloat(srcBlendId, (float)srcBlend);
        //block.SetFloat(dstBlendId, (float)dstBlend);
        //block.SetFloat(zWriteId, (float)zWrite);
        block.SetFloat(cutoffId, cutoff);
        GetComponent<Renderer>().SetPropertyBlock(block);
    }
    private void Awake()
    {
        OnValidate();
    }
    public enum OnOff
    {
        Off = 0,
        On = 1
    }
}
