Shader "Custom/VertexFresnelShader"  {
	Properties{
		_Color("Tint", Color) = (1,1,1,1)
		_FresnelColor("Fresnel Color", Color) = (0,0,0,1)
		_FresnelBias("Fresnel Bias", Float) = 0
		_FresnelScale("Fresnel Scale", Range(0,1)) = 1
		_FresnelPower("Fresnel Power", Float) = 1
	}
		SubShader
	{
		Tags {
			"Queue" = "Geometry"
			"IgnoreProjector" = "True"
			"RenderType" = "Opaque"
		}
		Cull Back
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#include "UnityCG.cginc"
			struct appdata_t {
				float4 pos : POSITION;
				half3 normal : NORMAL;
			};
	struct v2f {
		float4 pos : SV_POSITION;
		half2 uv : TEXCOORD0;
		float fresnel : TEXCOORD1;
	};
	fixed4 _Color;
	fixed4 _FresnelColor;
	fixed _FresnelBias;
	fixed _FresnelScale;
	fixed _FresnelPower;
	v2f vert(appdata_t v) {
		v2f o;
		o.pos = UnityObjectToClipPos(v.pos);
		float3 i = normalize(ObjSpaceViewDir(v.pos));
		o.fresnel = _FresnelBias + _FresnelScale * pow(1 + dot(i, v.normal), _FresnelPower);
		return o;
	}
	fixed4 frag(v2f i) : SV_Target
	{
		fixed4 c = _Color;
		return lerp(c, _FresnelColor, 1 - i.fresnel);
	}
		ENDCG
	}
	}
}

