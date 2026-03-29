extends Node3D

@export var camera_sensitivity = 0.004
@export var max_zoom = 30
@export var min_zoom = 5

@onready var camera_3d: Camera3D = $Camera3D
@export var focus_point: Marker3D

var player: Player

func _ready() -> void:
	player = get_parent()
	set_as_top_level(true)

func _physics_process(_delta: float) -> void:
	_camera_zoom()
	global_position = focus_point.global_position
	#look_at(focus_point.position)

func _input(event):
	if event.is_action_pressed("ui_cancel"): get_tree().quit()

func _camera_zoom():
	var zoom_amount = 0
	if Input.is_action_just_pressed("zoom_in"):
		zoom_amount -= 1
	elif Input.is_action_just_pressed("zoom_out"):
		zoom_amount += 1
	camera_3d.fov = clamp(camera_3d.fov + zoom_amount, min_zoom, max_zoom)
