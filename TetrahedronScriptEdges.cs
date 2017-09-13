using System;
using UnityEngine;

public class TetrahedronScript : MonoBehaviour {

	 
	 //	Tetrahedron defined by (+-1,0,-w) and (0,+-1,w) where w = 1/sqrt(2)

	public Material tetrahedronMaterial;
	public Vector3[] p;
	float w = 1 / Mathf.Sqrt (2);
	Mesh tetrahedronMesh;
	static float normalizedScale = 1f/1f;

	/*
	private void OnDrawGizmos () {
		if (p == null) {
			return;
		}
		Gizmos.color = Color.red;
		for (int i = 0; i < p.Length; i++) {
			Gizmos.DrawSphere(p[i], 0.1f);
		}
	}
	*/
		

	void Generate(){

		gameObject.AddComponent<MeshRenderer> ().material = tetrahedronMaterial;

		tetrahedronMesh = new Mesh ();
		gameObject.AddComponent<MeshFilter> ().mesh = tetrahedronMesh;
		tetrahedronMesh.name = "Tetrahedron Mesh";


		p = new Vector3[4];
		Vector2[] uv = new Vector2[4];

		p [0] = new Vector3 (-1f, 0f, -w);
		p [1] = new Vector3 (1f, 0f, -w);
		p [2] = new Vector3 (0f, -1f, w);
		p [3] = new Vector3 (0f, 1f, w);
		tetrahedronMesh.vertices = p;

		uv [0] = new Vector2 (0f, 0f);
		uv [1] = new Vector2 (1f, 0f);
		uv [2] = new Vector2 (0f, 1f);
		uv [3] = new Vector2 (1f, 1f);

		tetrahedronMesh.uv = uv;


		int[] triangles = new int[12];

		triangles [0] = 0;
		triangles [1] = 3;
		triangles [2] = 1;

		triangles [3] = 0;
		triangles [4] = 1;
		triangles [5] = 2;

		triangles [6] = 0;
		triangles [7] = 2;
		triangles [8] = 3;

		triangles [9] = 1;
		triangles [10] = 3;
		triangles [11] = 2;

		tetrahedronMesh.triangles = triangles;
		tetrahedronMesh.RecalculateNormals ();

		transform.localScale *= normalizedScale;

		int triangleDensity = 10;
		GenerateEdgeMatrix(triangles, p, triangleDensity);

	}

	void GenerateEdgeMatrix(int[] tr, Vector3[] pt, int trDensity ){

		int triangleCount = tr.length/3;

		Vector3[] normals = new Vector3[trinagleCount];

		int[,] edges = new int[p.length*trDensity,2];
		int[,] edgeTriangles = new int[p.length*trDensity,2];
		float[] edgeAngles = new int[p.length*trDensity];

		int[] triangle = new int[3];
		int[] triangleOrdered = new int[3];

		for (int i = 0, i < triangleCount, i++){

			triangle[0] = tr[3*i];
			triangle[1] = tr[3*i+1];
			triangle[2] = tr[3*i+2];

			//populate normals array
			normals[i] = Vector3D.CrossProduct(pt[triangle[1]]-pt[triangle[0]],pt[triangle[2]]-pt[triangle[1]]);

			// order vertices by value
			triangleOrdered = Array.Sort(triangle);
			
			// populate edge matrix
			if 




		}








	}







	void Awake (){
		Generate ();
	}

	void Update(){
		transform.localRotation = Quaternion.Euler ((float)DateTime.Now.TimeOfDay.TotalSeconds * 15f* 2,(float)DateTime.Now.TimeOfDay.TotalSeconds * 20f* 2,(float)DateTime.Now.TimeOfDay.TotalSeconds * 25f* 2);
		//transform.localRotation = Quaternion.Euler (0f, 0f, 0f);
		}
		

}