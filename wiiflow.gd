extends Node3D

# https://art.gametdb.com/wii/coverfullHQ/EN/GSAP01.png
@export var games: Array[StringName] = []
@onready var camera_3d: WiiFlowCamera = $Camera3D

var is_game_selected: bool = false
var target_camera_pos: Vector3 = Vector3.ZERO
var target_camera_aim: Vector3 = Vector3.ZERO
var num_columns: int = 11
var num_rows: int = 1

var current_tick_count: int = 0

#var current_layout_settings: LayoutSettings = null

const default_case_color: Color = Color(0.1, 0.1, 0.1)

const custom_case_colors: Dictionary[StringName, Color] = {
	"GM4P01": Color.ORANGE_RED
}

var case_color_materials: Dictionary[Color, Material] = {
	
}

@export_category("Layout Settings Normal")
@export var layout_settings_normal: LayoutSettings

@export_category("Layout Settings Selected")
@export var layout_settings_selected: LayoutSettings

@onready var covers: Node3D = $Covers

var current_index: int = 0
var normal_speed: float = 0.1
var selected_speed: float = 0.07

@onready var http_request: HTTPRequest = $HTTPRequest

var current_game_index: int = 0

# TODO: Change Cam FOV when not using 16:9
#if (CONF_GetAspectRatio() == CONF_ASPECT_16_9)
		#guPerspective(m_projMtx, 45, 16.f / 9.f, .1f, 300.f);
	#else
		#guPerspective(m_projMtx, RadToDeg(2.f * atan(tan(DegToRad(45 / 2)) / (4.f / 3.f) * (16.f / 9.f))), 4.f / 3.f, .1f, 300.f);
	#

const COVER = preload("res://cover.tscn")
func add_game(game_id: StringName, texture: ImageTexture) -> void:
	var case_color: Color = default_case_color
	
	if game_id in custom_case_colors:
		case_color = custom_case_colors[game_id] #default_case_color

	var cover: Cover = COVER.instantiate()

	cover.setup(game_id, texture, case_color)

	cover.name = game_id
	
	covers.add_child(cover)
	cover.scale = Vector3.ZERO
	cover.position = Vector3(0.0, 0.0, 0.0)

#func set_range(rows: int, columns: int) -> void:
	#

func _update_all_targets(instant: bool = false) -> void:
	print("Updating all targets")
	num_columns = covers.get_child_count()
	target_camera_pos = layout_settings_selected.camera_pos if is_game_selected else layout_settings_normal.camera_pos
	target_camera_aim = layout_settings_selected.camera_look_at if is_game_selected else layout_settings_normal.camera_look_at
	for i in range(covers.get_child_count()):
		_update_target(i, instant)

func _update_target(idx: int, instant: bool = false) -> void:
	var current_layout_settings: LayoutSettings = layout_settings_selected if is_game_selected else layout_settings_normal
	var h_center: int = num_columns / 2
	var v_center: int = num_rows / 2
	var x: int = idx / num_rows
	var y: int = idx % num_rows
	
	var cover: Cover = covers.get_child(idx)
	
	# Left covers
	if x < h_center:
		var delta_angle: Vector3 = current_layout_settings.left_delta_angle * (h_center - 1 - x)
		cover.target_angle = layout_settings_normal.left_angle + delta_angle
		cover.target_position = current_layout_settings.left_pos + current_layout_settings.left_spacer.rotated(Vector3.UP, delta_angle.y * 0.5) * (h_center - 1 - x)
		cover.target_scale = current_layout_settings.left_scale
	# right covers
	elif x > h_center:
		var delta_angle: Vector3 = current_layout_settings.right_delta_angle * (x - h_center - 1)
		cover.target_angle = layout_settings_normal.right_angle + delta_angle
		cover.target_position = current_layout_settings.right_pos + current_layout_settings.right_spacer.rotated(Vector3.UP, delta_angle.y * 0.5) * (x - h_center - 1)
		cover.target_scale = current_layout_settings.right_scale
	# new center cover
	elif y == v_center:
		cover.target_angle = current_layout_settings.center_angle
		cover.target_position = current_layout_settings.center_pos
		cover.target_scale = current_layout_settings.center_scale
	# center of a row
	else:
		pass

	if instant:
		_instant_target(idx)
		
func _instant_target(idx: int) -> void:
	var cover: Cover = covers.get_child(idx)
	
	cover.rotation_degrees = cover.target_angle
	cover.position = cover.target_position

func _cameraMoves() -> Vector3:
	var current_layout_settings: LayoutSettings = layout_settings_selected if is_game_selected else layout_settings_normal
	var float_tick: float = float(current_tick_count) * 0.005
	return Vector3(
		cos(float_tick * current_layout_settings.camera_oscillation_speed.x) * current_layout_settings.camera_oscilliation_amplification.x,
		sin(float_tick * current_layout_settings.camera_oscillation_speed.y) * current_layout_settings.camera_oscilliation_amplification.y,
		cos(float_tick * current_layout_settings.camera_oscillation_speed.z) * current_layout_settings.camera_oscilliation_amplification.z
	)

func _coverMovesA() -> Vector3:
	var current_layout_settings: LayoutSettings = layout_settings_selected if is_game_selected else layout_settings_normal
	var float_tick: float = float(current_tick_count) * 0.005
	return Vector3(
		cos(float_tick * current_layout_settings.cover_oscillation_a_speed.x) * current_layout_settings.cover_oscillation_a_amplification.x,
		sin(float_tick * current_layout_settings.cover_oscillation_a_speed.y) * current_layout_settings.cover_oscillation_a_amplification.y,
		cos(float_tick * current_layout_settings.cover_oscillation_a_speed.z) * current_layout_settings.cover_oscillation_a_amplification.z
		)

func _coverMovesP() -> Vector3:
	var current_layout_settings: LayoutSettings = layout_settings_selected if is_game_selected else layout_settings_normal
	var float_tick: float = float(current_tick_count) * 0.005
	return Vector3(
		cos(float_tick * current_layout_settings.cover_oscillation_p_speed.x) * current_layout_settings.cover_oscillation_p_amplification.x,
		sin(float_tick * current_layout_settings.cover_oscillation_p_speed.y) * current_layout_settings.cover_oscillation_p_amplification.y,
		cos(float_tick * current_layout_settings.cover_oscillation_p_speed.z) * current_layout_settings.cover_oscillation_p_amplification.z
		)
	
func _left(step: int = 1) -> void:
	var prev: int = 0
	var arrStep: int = 0
	var range: int = num_rows * num_columns
	var cover: Cover = covers.get_child(range / 2)
	cover.rotation_degrees += _coverMovesA()
	cover.position += _coverMovesP()
	
	if num_rows >= 3:
		pass
	else:
		prev = covers.get_child(range / 2).get_index() # should be range / 2?
		arrStep = step % (num_rows - 2) + (step / (num_rows - 2)) * num_rows
		for i in range(range - 1, 0, -1):
			covers.move_child(covers.get_child(i-1), i)
			pass
		_update_all_targets()
		_instant_target(0)
	
	covers.get_child(range / 2).rotation_degrees -= _coverMovesA()
	covers.get_child(range / 2).position -= _coverMovesP()

func _right(step: int = 1) -> void:
	var prev: int = 0
	var arrStep: int = 0
	var range: int = num_rows * num_columns
	var cover: Cover = covers.get_child(range / 2)
	cover.rotation_degrees += _coverMovesA()
	cover.position += _coverMovesP()
	
	if num_rows >= 3:
		pass
	else:
		prev = covers.get_child(range - 1).get_index() # should be range / 2?
		arrStep = step % (num_rows - 2) + (step / (num_rows - 2)) * num_rows
		for i in range(0, range - 1, 1):
			covers.move_child(covers.get_child(i+1), i)
			pass
		_update_all_targets()
		_instant_target(range - 1)
	
	covers.get_child(range / 2).rotation_degrees -= _coverMovesA()
	covers.get_child(range / 2).position -= _coverMovesP()

func _physics_process(delta: float) -> void:
	tick()
	current_tick_count += 1
	
	if Input.is_action_just_pressed("ui_left"):
		_left()
	if Input.is_action_just_pressed("ui_right"):
		_right()
	if Input.is_action_just_pressed("ui_accept"):
		select()
	if Input.is_action_just_pressed("ui_cancel"):
		unselect()

func _cover_tick(idx: int) -> void:
	var speed: float = selected_speed if is_game_selected else normal_speed
	var cover: Cover = covers.get_child(idx)
	var pos_dist: Vector3 = cover.target_position - cover.position
	
	if pos_dist.length_squared() < 0.5:
		speed *= 0.5
		
	#cover.rotation_degrees += _coverMovesA()
	#cover.position += _coverMovesP()
		
	cover.rotation_degrees += (cover.target_angle - cover.rotation_degrees) * speed
	cover.position += pos_dist * speed
	cover.scale += (cover.target_scale - cover.scale) * speed

func unselect() -> void:
	if not is_game_selected:
		return
		
	var current_idx: int = covers.get_child_count() / 2
		
	camera_3d.position += _cameraMoves()
	covers.get_child(current_idx).rotation_degrees += _coverMovesA()
	covers.get_child(current_idx).position += _coverMovesP()
	
	is_game_selected = false

	covers.get_child(current_idx).rotation_degrees -= _coverMovesA()
	covers.get_child(current_idx).position -= _coverMovesP()
	camera_3d.position -= _cameraMoves()
	
	target_camera_pos = layout_settings_normal.camera_pos
	target_camera_aim = layout_settings_normal.camera_look_at

	_update_all_targets()

func select() -> bool:
	if is_game_selected:
		return true
	
	var current_idx: int = covers.get_child_count() / 2
		
	camera_3d.position += _cameraMoves()
	covers.get_child(current_idx).rotation_degrees += _coverMovesA()
	covers.get_child(current_idx).position += _coverMovesP()
	
	is_game_selected = true
	
	covers.get_child(current_idx).rotation_degrees -= _coverMovesA()
	covers.get_child(current_idx).position -= _coverMovesP()
	camera_3d.position -= _cameraMoves()
	
	_update_all_targets()
	
	return true

func tick() -> void:
	# tick all covers
	num_columns = covers.get_child_count()
	
	for i in range(covers.get_child_count()):
		_cover_tick(i)
		
	camera_3d.position += _cameraMoves()
	
	camera_3d.position += (target_camera_pos - camera_3d.position) * 0.2
	camera_3d.camera_aim += (target_camera_aim - camera_3d.camera_aim) * 0.2
	camera_3d.look_at(camera_3d.camera_aim)

func get_game_image(game_id: String) -> void:
	if FileAccess.file_exists("res://games/%s.png" % game_id):
		# just load the image
		var file = FileAccess.get_file_as_bytes("res://games/%s.png" % game_id)
		var image: ImageTexture = ImageTexture.new()
		var img: Image = Image.new()
		var err = img.load_png_from_buffer(file)
		image = image.create_from_image(img)
		
		add_game(game_id, image)
		
		current_game_index += 1
		if current_game_index < games.size():
			get_game_image(games[current_game_index])
		else:
			_update_all_targets(true)
	else:
		http_request.request("https://art.gametdb.com/wii/coverfullHQ/EN/%s.png" % game_id)
		# get data from web and cache it for later

func _ready() -> void:
	target_camera_pos = layout_settings_normal.camera_pos
	target_camera_aim = layout_settings_normal.camera_look_at
	get_game_image(games.front())

@onready var grid_container: GridContainer = $Control/GridContainer

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var image: ImageTexture = ImageTexture.new()
	var img: Image = Image.new()
	var err = img.load_png_from_buffer(body)
	image = image.create_from_image(img)
	
	var file = FileAccess.open("res://games/%s.png" % games[current_game_index], FileAccess.WRITE)
	file.store_buffer(body)
	file.close()
	#var texture = TextureRect.new()
	#texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	#texture.expand_mode = TextureRect.EXPAND_FIT_	dWIDTH_PROPORTIONAL
	#texture.custom_minimum_size = Vector2(200, 200)
	#texture.texture = image
	#mat.albedo_texture = image
	#grid_container.add_child(texture)
	
	#add_game(games[current_game_index], image, current_game_index)
	
	current_game_index += 1
	if current_game_index < games.size():
		get_game_image(games[current_game_index])
		#http_request.request("https://art.gametdb.com/wii/coverfullHQ/EN/%s.png" % games[current_game_index])
	else:
		_update_all_targets(true)
