extends Task

# Tuning parameters
@export var movement_speed: float = 2.5
var target_position: Vector3 = Vector3.ZERO

func enter() -> void:
	print("ENTER: WALK TO")
	animations.play("universal_anim_library/Walk") # Changed to Walk
	
	# 1. Get a random reachable point or a specific offset
	# This assumes your enemy script has access to its NavigationAgent3D
	var nav_agent = enemy.nav_agent
	
	# Pick a random direction
	var random_direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()

	# Pick a random distance between 2 and 6 units
	var random_distance = randf_range(7.0, 15.0)

	target_position = enemy.global_position + (random_direction * random_distance)
	
	# 2. Tell the agent where to go
	nav_agent.target_position = target_position

func physics_update(delta: float) -> void:
	var nav_agent = enemy.nav_agent
	
	# 1. Arrival Check
	if nav_agent.is_navigation_finished():
		emit_task_finished(true)
		return

	# 2. Movement Calculation
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = (next_path_pos - enemy.global_position).normalized()
	enemy.velocity = direction * movement_speed
	enemy.move_and_slide()

	# 3. Rotation Based on Velocity (Flipped for -Z Forward)
	if enemy.velocity.length() > 0.1:
		# Adding PI (180 degrees) flips the rotation to the opposite side
		var target_angle = atan2(-enemy.velocity.x, -enemy.velocity.z)
		# Alternatively, you can use: atan2(-enemy.velocity.x, -enemy.velocity.z)
		# Both achieve the same 'flip' effect.
		enemy.rotation.y = lerp_angle(enemy.rotation.y, target_angle, delta * 10.0)

	# 1. Get a list of all physics bodies currently inside the Area3D
	var overlapping_bodies = enemy.detection_area.get_overlapping_bodies()
	# 2. Loop through them to find the Player
	for body in overlapping_bodies:
		if body is Player:
			# Optional: Add a Line-of-Sight check here if you don't 
			# want the enemy to see the player through walls!
			enemy.player = body
			emit_task_finished(true)
			break # Stop looking once the player is found
