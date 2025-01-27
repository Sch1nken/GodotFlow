class_name LayoutSettings
extends Resource

@export_subgroup("Camera")
@export var camera_pos: Vector3 = Vector3(0.0, 1.5, 5.0)
@export var camera_look_at: Vector3 = Vector3(0.0, 0.0, -1.0)
@export var camera_oscillation_speed: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var camera_oscilliation_amplification: Vector3 = Vector3(0.0, 0.0, 0.0)

@export_subgroup("Cover")
@export var cover_oscillation_a_speed: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var cover_oscillation_a_amplification: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var cover_oscillation_p_speed: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var cover_oscillation_p_amplification: Vector3 = Vector3(0.0, 0.0, 0.0)

@export_subgroup("Scales")
@export var left_scale: Vector3 = Vector3(1.0, 1.0, 1.0)
@export var right_scale: Vector3 = Vector3(1.0, 1.0, 1.0)
@export var center_scale: Vector3 = Vector3(1.0, 1.0, 1.0)
@export var row_center_scale: Vector3 = Vector3(1.0, 1.0, 1.0)

@export_subgroup("Position")
@export var left_pos: Vector3 = Vector3(-1.6, 0.0, 0.0)
@export var right_pos: Vector3 = Vector3(1.6, 0.0, 0.0)
@export var center_pos: Vector3 = Vector3(0.0, 0.0, 0.0)

@export_subgroup("Angles")
@export var left_angle: Vector3 = Vector3(0.0, 70.0, 0.0)
@export var right_angle: Vector3 = Vector3(0.0, -70.0, 0.0)
@export var left_delta_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var right_delta_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var top_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var bottom_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var top_delta_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var bottom_delta_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var center_angle: Vector3 = Vector3(0.0, 0.0, 0.0)
@export var row_center_angle: Vector3 = Vector3(0.0, 0.0, 0.0)

@export_subgroup("Spacing")
@export var left_spacer: Vector3 = Vector3(-0.35, 0.0, 0.0)
@export var right_spacer: Vector3 = Vector3(0.35, 0.0, 0.0)
@export var top_spacer: Vector3 = Vector3(0.0, 2.0, 0.0)
@export var bottom_spacer: Vector3 = Vector3(0.0, -2.0, 0.0)
