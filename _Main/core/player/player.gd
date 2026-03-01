extends CharacterBody3D
class_name Player

@export var move_speed = 5.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
