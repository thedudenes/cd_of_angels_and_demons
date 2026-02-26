extends Node3D

@export var camera_sensitivity = 0.004
@export var max_zoom = 20
@export var min_zoom = 10

@onready var camera_3d: Camera3D = $Camera3D

func _ready() -> void:
# Disconnects from parent transformation matrix
	set_as_top_level(true)
	

func _physics_process(_delta: float) -> void:
	_camera_zoom()
	var player = get_parent()
	global_position = player.global_position

func _input(event):
	if event.is_action_pressed("ui_cancel"): get_tree().quit()

func _camera_zoom():
	var zoom_amount = 0
	if Input.is_action_just_pressed("zoom_in"):
		zoom_amount -= 1
	elif Input.is_action_just_pressed("zoom_out"):
		zoom_amount += 1
	camera_3d.size += zoom_amount
	camera_3d.size = clamp(camera_3d.size, min_zoom, max_zoom)
