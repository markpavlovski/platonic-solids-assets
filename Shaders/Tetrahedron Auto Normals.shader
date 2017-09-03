// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom / Tetrahedron Auto Normals" {

	Properties {

		_Tint ("Tint", Color) = (1,1,1,1)
		_MainTex( "Texture", 2D) = "white" {}
		_Color013 ("Color013", Color) = (1,1,1,1)
		_Color012 ("Color012", Color) = (1,1,1,1)
		_Color023 ("Color023", Color) = (1,1,1,1)
		_Color132 ("Color132", Color) = (1,1,1,1)
		_Epsilon ("Epsilon", Range(0,1)) = 0.01


	}




	Subshader {

		Pass {

			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"

			float4 	_Tint;
			float4 	_Color013;
			float4 	_Color132;
			float4 	_Color012;
			float4 	_Color023;
			float 	_Epsilon;

			struct Interpolators {
				float4 position : SV_POSITION;
				float3 localPosition : TEXCOORD0;

			};

			Interpolators MyVertexProgram (float4 position : POSITION) {
				Interpolators i;
				i.localPosition = position.xyz;
				i.position = UnityObjectToClipPos(position);
				return i;
			}

			float4 MyFragmentProgram (Interpolators i) : SV_TARGET {

				float3 n013 = float3(0.0,-pow(2.0,0.5),1.0);
				float3 n012 = float3(0.0,pow(2.0,0.5),1.0); // orientation matters!
				float3 n023 = float3(pow(2.0,0.5),0.0,-1.0);
				float3 n132 = float3(-pow(2.0,0.5),0.0,-1.0);

				float3 ptA = float3(-1.0,0.0,-pow(2.0,-0.5));
				float3 ptB = float3(1.0,0.0,-pow(2.0,-0.5));

				float3 pt013 = ptA;
				float3 pt012 = ptA;
				float3 pt023 = ptA;
				float3 pt132 = ptB;


				float3 localPosition = i.localPosition;
				float4 normals = i.position.normal;
				float eps = 1 + _Epsilon;

			
				float3 fragColor = 1.0 * _Color013.xyz * (step(dot(n013,localPosition), dot(n013,pt013) / eps)-step(dot(n013,localPosition), dot(n013,pt013) * eps)) 
								 + 1.0 * _Color132.xyz * (step(dot(n132,localPosition), dot(n132,pt132) / eps)-step(dot(n132,localPosition), dot(n132,pt132) * eps))
								 + 1.0 * _Color012.xyz * (step(dot(n012,localPosition), dot(n012,pt012) / eps)-step(dot(n012,localPosition), dot(n012,pt012) * eps))
								 + 1.0 * _Color023.xyz * (step(dot(n023,localPosition), dot(n023,pt023) / eps)-step(dot(n023,localPosition), dot(n023,pt023) * eps));

				return float4(fragColor,1.0);
			}


			ENDCG

		}

	}
	
}