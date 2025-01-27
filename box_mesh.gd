class_name CaseMesh
extends Resource

const g_coverBL: Vector3 = Vector3(-0.65, -0.915, 0.0)
const g_coverTR: Vector3 = Vector3(0.65, 0.915, 0.0)
const g_boxCoverY: float = 0.1
const g_boxBorderWidth: float = 0.025
const g_frontCoverBL: Vector3 = Vector3(g_coverBL.x, g_coverBL.y, g_coverBL.z)
const g_frontCoverTR: Vector3 = Vector3(g_coverTR.x, g_coverTR.y, g_coverTR.z)
const g_backCoverBL: Vector3 = Vector3(g_frontCoverBL.x, g_frontCoverBL.y, g_frontCoverBL.z - 0.16)
const g_backCoverTR: Vector3 = Vector3(g_frontCoverTR.x, g_frontCoverTR.y, g_frontCoverTR.z - 0.16)
const g_boxCoverYCenter: float = (g_frontCoverTR.y - g_frontCoverBL.y) * 0.5
const g_coverYCenter: float = (g_coverTR.y - g_coverBL.y) * 0.5
const g_boxSize: Vector3 = Vector3(
	g_coverTR.x - g_coverBL.x + 2 * g_boxBorderWidth,
	g_coverTR.y - g_coverBL.y + 2 * g_boxBorderWidth,
	g_coverTR.z - g_coverBL.z + 2 * g_boxBorderWidth)

static func w(x: float) -> float:
	return x / 64.0
	
static func h(y: float) -> float:
	return y / 256.0

class SMeshVert:
	var pos: Vector3
	var texCoord: Vector2
	
	func _init(p: Vector3, coord: Vector2) -> void:
		pos = p
		texCoord = coord

# CTexcoord = Vector2
static var g_boxMeshQ: Array[SMeshVert] = [ # Quads
	# Bordure du bas devant
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y,						g_frontCoverBL.z ),						Vector2(w(0), h(256)) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y - g_boxBorderWidth,	g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(256)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y - g_boxBorderWidth,	g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(224)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y,						g_frontCoverBL.z ),						Vector2(w(0), h(224)) ),

	# Bordure du haut devant
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y + g_boxBorderWidth,	g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y, 					g_frontCoverBL.z ),						Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y,						g_frontCoverBL.z ),						Vector2(w(0), h(32)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y + g_boxBorderWidth,	g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(32)) ),

	# Bordure du bas derri�re
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y - g_boxBorderWidth,	g_backCoverBL.z + g_boxBorderWidth),	Vector2(w(54), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y,						g_backCoverBL.z),						Vector2(w(64), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y,						g_backCoverBL.z),						Vector2(w(64), h(224)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y - g_boxBorderWidth,	g_backCoverBL.z + g_boxBorderWidth),	Vector2(w(54), h(224)) ),

	# Bordure du haut derri�re
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y,						g_backCoverBL.z),						Vector2(w(64), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y + g_boxBorderWidth,	g_backCoverBL.z + g_boxBorderWidth),	Vector2(w(54), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y + g_boxBorderWidth,	g_backCoverBL.z + g_boxBorderWidth),	Vector2(w(54), h(32)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y,						g_backCoverBL.z),						Vector2(w(64), h(32)) ),

	# Bordure de droite devant
	SMeshVert.new(Vector3(g_frontCoverTR.x,						g_frontCoverBL.y, g_frontCoverBL.z ),						Vector2(w(0), h(256)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth,	g_frontCoverBL.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(256)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth,	g_frontCoverTR.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x,						g_frontCoverTR.y, g_frontCoverBL.z ),						Vector2(w(0), h(0)) ),

	# Bordure de droite derri�re
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth,	g_backCoverBL.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x,					g_backCoverBL.y, g_backCoverBL.z ),							Vector2(w(64), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x,					g_backCoverTR.y, g_backCoverBL.z ),							Vector2(w(64), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth,	g_backCoverTR.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(0)) ),

	# Face du haut
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y + g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y + g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(32)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y + g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(32)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y + g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(0)) ),

	# Angle face du haut / face de droite
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y + g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(32)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth, g_frontCoverTR.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth, g_backCoverTR.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y + g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(32)) ),

	# Face de droite
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth, g_frontCoverTR.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth, g_frontCoverBL.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth, g_backCoverBL.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth, g_backCoverTR.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(0)) ),

	# Angle face de droite / face du bas
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth, g_frontCoverBL.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(256)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y - g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(224)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y - g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(224)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth, g_backCoverBL.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(256)) ),

	# Face du bas
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y - g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(224)) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y - g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y - g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y - g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(224)) ),
	
	# Face de gauche en haut
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y, g_frontCoverBL.z ),											Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y + g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y + g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y, g_backCoverBL.z),												Vector2(w(0), h(0)) ),

	# Face de gauche en bas
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y - g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y, g_frontCoverBL.z ),											Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y, g_backCoverBL.z ),											Vector2(w(0), h(0)) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y - g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(0), h(0)) )
]

static var g_boxMeshT: Array[SMeshVert] = [
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y, g_frontCoverBL.z ),											Vector2(w(0), h(16)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth, g_frontCoverTR.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(0)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y + g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(32)) ),

	# Haut derri�re
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y, g_backCoverBL.z ),											Vector2(w(64), h(16)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y + g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(32)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth, g_backCoverTR.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(0)) ),

	# Bas devant
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y, g_frontCoverBL.z ),											Vector2(w(0), h(240)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y - g_boxBorderWidth, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(224)) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x + g_boxBorderWidth, g_frontCoverBL.y, g_frontCoverBL.z - g_boxBorderWidth ),	Vector2(w(10), h(256)) ),

	# Bas derri�re
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y, g_backCoverBL.z ),											Vector2(w(64), h(240)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x + g_boxBorderWidth, g_backCoverBL.y, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(256)) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y - g_boxBorderWidth, g_backCoverBL.z + g_boxBorderWidth ),		Vector2(w(54), h(224)) )
]

static var g_flatCoverMesh: Array[SMeshVert] = [
	SMeshVert.new(Vector3(g_coverBL.x, g_coverBL.y, g_coverBL.z ), Vector2(0.0, 1.0) ),
	SMeshVert.new(Vector3(g_coverTR.x, g_coverBL.y, g_coverBL.z ), Vector2(1.0, 1.0) ),
	SMeshVert.new(Vector3(g_coverTR.x, g_coverTR.y, g_coverBL.z ), Vector2(1.0, 0.0) ),
	SMeshVert.new(Vector3(g_coverBL.x, g_coverTR.y, g_coverBL.z ), Vector2(0.0, 0.0) )
]

static var g_flatCoverBoxTex: Array[Vector2] = [
	Vector2(1.46 / 2.76, 1.0),
	Vector2(1.0, 1.0),
	Vector2(1.0, 0.0),
	Vector2(1.46 / 2.760, 0.0)
]

static var g_boxBackCoverMesh: Array[SMeshVert] = [
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverBL.y, g_backCoverBL.z ), Vector2(0.0, 1.0) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y, g_backCoverBL.z ), Vector2(1.3/ 2.76, 1.0) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y, g_backCoverBL.z ), Vector2(1.3/ 2.76, 0.0) ),
	SMeshVert.new(Vector3(g_backCoverTR.x, g_backCoverTR.y, g_backCoverBL.z ), Vector2(0.0, 0.0) ),

	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y, g_frontCoverBL.z ), Vector2(1.46/ 2.76, 1.0) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y, g_frontCoverBL.z ), Vector2(1.46/ 2.76, 0.0) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverTR.y, g_backCoverBL.z ), Vector2(1.3/ 2.76, 0.0) ),
	SMeshVert.new(Vector3(g_backCoverBL.x, g_backCoverBL.y, g_backCoverBL.z ), Vector2(1.3/ 2.76, 1.0) )
]

static var g_boxCoverMesh: Array[SMeshVert] = [
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverBL.y, g_frontCoverBL.z ), Vector2(1.46 / 2.76, 1.0) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverBL.y, g_frontCoverBL.z ), Vector2(1.0, 1.0) ),
	SMeshVert.new(Vector3(g_frontCoverTR.x, g_frontCoverTR.y, g_frontCoverBL.z ), Vector2(1.0, 0.0) ),
	SMeshVert.new(Vector3(g_frontCoverBL.x, g_frontCoverTR.y, g_frontCoverBL.z ), Vector2(1.46 / 2.76, 0.0) )
]

static var g_boxCoverFlastTex: Array[Vector2] = [
	Vector2(0.0, 1.0),
	Vector2(1.0, 1.0),
	Vector2(1.0, 0.0),
	Vector2(0.0, 0.0)
]

static var g_boxCoverBackTex: Array[Vector2] = [
	Vector2(0.0, 1.0),
	Vector2(1.3/ 1.46, 1.0),
	Vector2(1.3/ 1.46, 0.0),
	Vector2(0.0, 0.0),

	Vector2(1.0, 1.0),
	Vector2(1.0, 0.0),
	Vector2(1.3/ 1.46, 0.0),
	Vector2(1.3/ 1.46, 1.0)
]

enum MESH_TYPE {
	TRIANGLES,
	QUADS
}

static var setup_done: bool = false

static func setup() -> void:
	if setup_done:
		return
		
	g_boxMeshQ.reverse()
	g_boxMeshT.reverse()
	g_flatCoverMesh.reverse()
	g_boxBackCoverMesh.reverse()
	
	g_flatCoverBoxTex.reverse()
	
	setup_done = true

static func create_mesh() -> Mesh:
	setup()
	
	var out: Mesh = Mesh.new()
	
	var meshes: Array = [
		g_boxMeshQ,
		g_boxMeshT,
		g_flatCoverMesh,
		g_boxBackCoverMesh
	]
	
	var types: Array = [
		MESH_TYPE.QUADS,
		MESH_TYPE.TRIANGLES,
		MESH_TYPE.QUADS,
		MESH_TYPE.QUADS
	]
	
	var special_uvs: Array = [
		null,
		null,
		g_flatCoverBoxTex,
		null
	]
	
	for k in range(meshes.size()):
		var st = SurfaceTool.new()
	
		st.begin(Mesh.PRIMITIVE_TRIANGLES)
		
		var arr_to_use = meshes[k] #g_boxMeshQ
		
		#arr_to_use.reverse()
				
		#if special_uvs[k] != null:
			#special_uvs[k].reverse()
		
		for i in range(arr_to_use.size()):
			if special_uvs[k] != null:
				st.set_uv(special_uvs[k][i])
			else:
				st.set_uv(arr_to_use[i].texCoord)
			st.set_color(Color(float(i) / arr_to_use.size(), float(i) / arr_to_use.size(), float(i) / arr_to_use.size()))
			st.add_vertex(arr_to_use[i].pos)

		if types[k] == MESH_TYPE.QUADS:
			for i in range(0, arr_to_use.size(), 4):
				st.add_index(i)
				st.add_index(i+1)
				st.add_index(i+2)
				
				st.add_index(i)
				st.add_index(i+2)
				st.add_index(i+3)
				
		elif types[k] == MESH_TYPE.TRIANGLES:
			for i in range(0, arr_to_use.size(), 3):
				st.add_index(i)
				st.add_index(i+1)
				st.add_index(i+2)
				
		out = st.commit(out)
	
	return out
