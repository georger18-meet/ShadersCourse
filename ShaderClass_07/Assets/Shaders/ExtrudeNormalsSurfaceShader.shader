Shader "Custom/ExtrudeNormalsSurfaceShader"
{
	Properties
	{
		_Amount("Extrusion Amount", Range(-1,1)) = 0
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 normal : NORMAL;
				fixed3 color : COLOR0;
			};
struct v2f
			{
			   float4 vertex : SV_POSITION;
			   fixed3 color : COLOR0;
			};
float _Amount;


v2f vert(appdata v)
{
	v2f o;
	o.vertex = UnityObjectToClipPos(v.vertex);
	o.vertex.xyz += v.normal * _Amount;
	o.color = v.color;
	return o;
}

fixed4 frag(v2f i) : SV_Target
{
	return fixed4(i.color, 1);
}
ENDCG
	}
	}

    //Properties
    //{
    //    _MainTex("Texture", 2D) = "white" {}
    //    _Amount("Multiplier", Float) = 5
    //}
    //    SubShader
    //    {
    //        Tags { "RenderType" = "Opaque" }
    //        LOD 100

    //        Pass
    //        {
    //            CGPROGRAM
    //            #pragma vertex vert
    //            #pragma fragment frag
    //            // make fog work
    //            #pragma multi_compile_fog

    //            #include "UnityCG.cginc"

    //            struct appdata
    //            {
    //                float4 vertex : POSITION;
    //                float2 uv : TEXCOORD0;
    //                float4 normal : NORMAL;
    //            };

    //            struct v2f
    //            {
    //                float2 uv : TEXCOORD0;
    //                UNITY_FOG_COORDS(1)
    //                float4 vertex : SV_POSITION;
    //            };

    //            sampler2D _MainTex;
    //            float4 _MainTex_ST;
    //            float _Amount;
    //            v2f vert(appdata v)
    //            {
    //                v2f o;
    //                v.vertex.xyz += v.normal * _Amount;
    //                o.vertex = UnityObjectToClipPos(v.vertex);
    //                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
    //                UNITY_TRANSFER_FOG(o,o.vertex);
    //                return o;
    //            }

    //            fixed4 frag(v2f i) : SV_Target
    //            {
    //                // sample the texture
    //                fixed4 col = tex2D(_MainTex, i.uv);
    //            // apply fog
    //            UNITY_APPLY_FOG(i.fogCoord, col);
    //            return col;
    //        }
    //        ENDCG
    //    }
    //    }
}
