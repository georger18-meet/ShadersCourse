Shader "Custom/SurfaceFresnelShader"
{
    Properties
    {
       _InnerColor("InnerColor", Color) = (0,0,0,0.0)
       _RimColor("Rim Color", Color) = (0.26,0.19,0.16,0.0)
      _RimPower("Rim Power", Range(0,15.0)) = 5.0
    }
        SubShader
    {
      Tags { "Queue" = "Transparent" }

      Cull Back
      BlendOp Max
      Blend SrcColor One
      ZWrite Off

      CGPROGRAM
      #pragma surface surf Lambert
        struct Input {
            float3 viewDir;
        };
        float4 _InnerColor;
       float4 _RimColor;
       float _RimPower;

        void surf(Input IN, inout SurfaceOutput o) {
            o.Albedo = _InnerColor.rgb;
           half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor * pow(rim, _RimPower);

        }

       ENDCG
    }
        Fallback "Diffuse"
}

