Shader "Example/Diffuse Simple"
{
	Properties{
		_Color("Some Color", Color) = (1,1,1,1)
		_MyVector("Some Vector", Vector) = (0,0,0,0)
	}

		SubShader{
			Tags{"RenderType" = "Opaque"}
			CGPROGRAM
	#pragma surface surf Lambert

			float4 _Color;
			float4 _MyVector;

		struct Input {
		float4 color : COLOR;
};
	void surf(Input IN, inout SurfaceOutput o) {
		//o.Albedo = 1; // 1 = (1,1,1,1) = white
		o.Albedo = _Color;
		o.Emission = _MyVector;
	}
	ENDCG
	}
		Fallback "Diffuse"
}