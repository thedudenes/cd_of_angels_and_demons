extends PlayerState

@export var acceleration: float = 10.0
@export var rotation_speed: float = 12.0

func enter() -> void:
	if animations:
		animations.play("universal_anim_library/Jog_Fwd")
		
func update(delta: float) -> void:
	# Get input
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var camera = get_viewport().get_camera_3d()
	var camera_basis = camera.global_transform.basis
	var direction = (camera_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	# Keep the movement strictly horizontal
	direction.y = 0 
	if direction:
		# Apply Movement
		player.velocity.x = lerp(player.velocity.x, direction.x * player.move_speed, acceleration * delta)
		player.velocity.z = lerp(player.velocity.z, direction.z * player.move_speed, acceleration * delta)
		
		# Rotate the Player Model to face movement direction
		var target_rotation = atan2(direction.x, direction.z)
		player.rotation.y = lerp_angle(player.rotation.y, target_rotation, rotation_speed * delta)
	else:
		switch_state.emit("idle")
