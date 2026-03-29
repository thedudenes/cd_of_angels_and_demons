extends Enemy
class_name Humanoid

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var slots: Dictionary[String, MeshInstance3D]
@export var meshes: Dictionary[String, Array]
@export var nav_agent: NavigationAgent3D

var spawn_point: Vector3

func _ready() -> void:
	spawn_point = global_position
	for key in slots:
		slots[key].mesh = meshes[key].pick_random()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
