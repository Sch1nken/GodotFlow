class_name Cover
extends Node3D

var target_angle: Vector3 = Vector3.ZERO
var target_position: Vector3 = Vector3.ZERO
var target_scale: Vector3 = Vector3.ONE

func _ready() -> void:
	$Mirror.scale = Vector3(1.0, -1.0, 1.0)

func _process(delta: float) -> void:
	$Mirror.global_position = $Normal.global_position
	$Mirror.global_position.y = $Mirror.global_position.y * -1

func setup(game_id: StringName, texture: ImageTexture, case_color: Color) -> void:
	var case_mat: StandardMaterial3D = StandardMaterial3D.new()
	var texture_mat: StandardMaterial3D = StandardMaterial3D.new()
	
	$Normal.mesh = CaseMesh.create_mesh()
	
	case_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	case_mat.albedo_color = case_color

	texture_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	texture_mat.albedo_texture = texture 
	# 0 & 1 -> case color
	$Normal.mesh.surface_set_material(0, case_mat)
	$Normal.mesh.surface_set_material(1, case_mat)
	
	# 2 & 3 -> front/back with texture
	$Normal.mesh.surface_set_material(2, texture_mat)
	$Normal.mesh.surface_set_material(3, texture_mat)
	
	var mesh: Mesh = $Normal.mesh
	$Mirror.mesh = mesh
	$Normal.position = Vector3(0.0, mesh.get_aabb().size.y / 2.0, 0.0)
