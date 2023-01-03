using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestScriptComputeShader : MonoBehaviour
{
    public ComputeShader shader;
    // Start is called before the first frame update
    void Start()
    {
        RunShader();
    }


    void RunShader()
    {
        int kernalHandle = shader.FindKernel("CSMain");
        RenderTexture tex = new RenderTexture(256, 256, 0);
        tex.enableRandomWrite = true;
        tex.Create();
        shader.SetTexture(kernalHandle, "Result", tex);
        shader.Dispatch(kernalHandle, 256 / 8, 256 / 8, 1);
        Renderer rend = GetComponent<Renderer>();
        //rend.enabled = true;
        rend.material.SetTexture("_MainTex", tex);
    }
}
